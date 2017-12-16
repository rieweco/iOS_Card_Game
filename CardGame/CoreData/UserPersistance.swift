import Foundation
import CoreData

class UserPersistence {
    let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    private func createRecordForEntity(_ entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> NSManagedObject? {
        var result: NSManagedObject?
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: entity, in: managedObjectContext)
        
        if let entityDescription = entityDescription {
            // Create Managed Object
            result = NSManagedObject(entity: entityDescription, insertInto: managedObjectContext)
        }
        
        return result
    }
    
    func insertUserInfo(with userInfo: UserInfo, complete:(() -> Void)?){
        
        let managedContext = coreDataManager.persistentContainer.viewContext
        do {
            var user = self.getUser(with: userInfo.username, context: managedContext)
            guard let _ = user else {
                user = User(context: managedContext)
                try user?.populate(from: userInfo)
                try managedContext.save()
                return
            }
            managedContext.delete(user!)
            user = User(context: managedContext)
            try user?.populate(from: userInfo)
            try managedContext.save()
            
        } catch let error as NSError {
            print(error)
        }
        complete?()
    }
    
    func addUser(with username: String, complete:(() -> Void)?) {
        let managedContext = coreDataManager.persistentContainer.viewContext
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedContext)
        user.setValue(username, forKey: "username")
        user.setValue(0, forKey: "wins")
        user.setValue("complete", forKey: "status")
        print("USER SAVED!!!!!!!!!!!!!!!!!!")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("could not save new User!!!!!!!!! \(error)")
        }
        complete?()

    }
    
  
    func getTheUsers(context: NSManagedObjectContext? = nil) -> [User]? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let results: [User]
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
    
    func getUser() -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let results = try coreDataManager.persistentContainer.viewContext.fetch(request)
            if let user = results.first{
                var userInfo: UserInfo?
                do{
                    try userInfo?.populate(from: user)
                }catch{
                    print(error)
                }
                
                if let username = user.username{
                   print(username)
                }
            }
            return results.first
        } catch {
            return nil
        }
    }
    
    func updateUserStatus(with username: String, with status: String) -> Bool?{
        let managedContext = coreDataManager.persistentContainer.viewContext
        do {
            guard let updateUser = self.getUser(with: username, context: managedContext)
                else{
                   print("No user existed with that username")
                    return false
            }
            updateUser.status = status
            try managedContext.save()
        } catch let error as NSError {
            print(error)
            
        }
        return true
    }
    
    func updateUserWins(with username: String) -> Bool? {
        let managedContext = coreDataManager.persistentContainer.viewContext
        do {
            guard let updateUser = self.getUser(with: username, context: managedContext)
                else {
                    print("No user existed with that username")
                    return false
            }
            var wins = updateUser.wins
            wins = wins + 1
            updateUser.wins = wins
            try managedContext.save()
        }catch let error as NSError {
            print(error)
        }
        return true
    }
    
    
    func getUser(with username: String, context: NSManagedObjectContext? = nil) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let results: [User]
            if let privateContext = context {
                results = try privateContext.fetch(request)
            } else {
                results = try coreDataManager.viewContext.fetch(request)
            }
            return results.first
        } catch {
            return nil
        }
    }
    
    func deleteUser(for userid: String) -> Bool {
        let fetch:NSFetchRequest<User> = User.fetchRequest()
        fetch.predicate = NSPredicate(format: "userId == %@", userid)
        
        do {
            let result = try coreDataManager.viewContext.fetch(fetch)
            if result.isEmpty {
                //Nothing to delete
                return false
            }
    
            guard result.first != nil else { return false }
            for user in result{
                coreDataManager.viewContext.delete(user)
            }
            
            try coreDataManager.viewContext.save()
            return true
        } catch {
            print("Failed to delete from Core data: \(error)")
            return false
        }
    }
}


