
import Foundation
import CoreData

class CoreDataManager {
    
    let storeLocation: URL? = {
        do{
            var storeDir = try FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            storeDir.appendPathComponent("Database")
            storeDir.appendPathExtension("sqlite")
            print(storeDir)
            return storeDir
        }catch{
            print("count not load Store url!!")
            return nil
        }
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        guard let storeUrl = self.storeLocation else {
            fatalError()
        }
        let container = NSPersistentContainer(name: "CardGame")
        let storeDescription = NSPersistentStoreDescription(url: storeUrl)
        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
   
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}









