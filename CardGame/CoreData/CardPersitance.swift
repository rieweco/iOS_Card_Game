import Foundation
import CoreData

class CardPersistence {
    let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func addCard(with name: String, icon: String, flipped: Bool, number: Int16, complete:(() -> Void)?) {
        let managedContext = coreDataManager.persistentContainer.viewContext
        let card = NSEntityDescription.insertNewObject(forEntityName: "Card", into: managedContext)
        card.setValue(name, forKey: "name")
        card.setValue(icon, forKey: "icon")
        card.setValue(false, forKey: "flipped")
        card.setValue(number, forKey: "number")
        print("CARD SAVED!!!!!!!!!!!!!!!!!!")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("could not save new Deck!!!!!!!!! \(error)")
        }
        complete?()
        
    }
    
    func getCards(context: NSManagedObjectContext? = nil) -> [Card]? {
        let request: NSFetchRequest<Card> = Card.fetchRequest()
        do {
            let results: [Card]
            if let privateContext = context {
                results = try privateContext.fetch(request)
            } else {
                results = try coreDataManager.viewContext.fetch(request)
            }
            return results
        } catch {
            return nil
        }
    }
    
    func flipCard(with number: Int16, complete: (() -> Void)?) {
        let managedContext = coreDataManager.persistentContainer.viewContext
        do {
            guard let card = self.getCards(context: managedContext)
                else {
                    print("No card exists")
                    return
            }
            if card[Int(number)].flipped == false {
                card[Int(number)].setValue(true, forKey: "flipped")
            }
            else {
                card[Int(number)].setValue(false, forKey: "flipped")
            }

        try managedContext.save()
    }catch let error as NSError {
        print(error)
    }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
            
        complete?()
    }
    
    func resetCards(complete: (() -> Void)?) {
        let managedContext = coreDataManager.persistentContainer.viewContext
        do {
            guard let card = self.getCards(context: managedContext)
                else {
                    print("No card exists")
                    return
            }
            card.forEach({ (eachCard) in
                managedContext.delete(eachCard)
            })
            try managedContext.save()
        }catch let error as NSError {
            print(error)
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        complete?()
    }
    
    
}
