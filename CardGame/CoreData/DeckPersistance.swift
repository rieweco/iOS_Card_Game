import Foundation
import CoreData

class DeckPersistence {
    let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func addDeck(with title: String, icon: String, status: String, complete:(() -> Void)?) {
        let managedContext = coreDataManager.persistentContainer.viewContext
        let deck = NSEntityDescription.insertNewObject(forEntityName: "Deck", into: managedContext)
        deck.setValue(title, forKey: "title")
        deck.setValue(icon, forKey: "icon")
        deck.setValue("complete", forKey: "status")
        print("DECK SAVED!!!!!!!!!!!!!!!!!!")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("could not save new Deck!!!!!!!!! \(error)")
        }
        complete?()
        
    }
    
    func getDecks(context: NSManagedObjectContext? = nil) -> [Deck]? {
        let request: NSFetchRequest<Deck> = Deck.fetchRequest()
        do {
            let results: [Deck]
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
    
    func resetDecks(complete: (() -> Void)?) {
        let managedContext = coreDataManager.persistentContainer.viewContext
        do {
            guard let deck = self.getDecks(context: managedContext)
                else {
                    print("No deck exists")
                    return
            }
            deck.forEach({ (eachDeck) in
                managedContext.delete(eachDeck)
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
