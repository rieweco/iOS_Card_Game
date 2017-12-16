import Foundation
import CoreData

extension User {
    func populate(from user: UserInfo) throws {
        self.username = user.username
        self.wins = user.wins
        self.status = user.status
    }
    
    static func fetch(from user: UserInfo) -> User? {
        let fetch: NSFetchRequest<User> = User.fetchRequest()
        fetch.predicate = NSPredicate(format: "username = [cd] %@",user.username)
        do {
            let results = try fetch.execute()
            if results.count > 1 || results.isEmpty {
                return nil
            }
            return results.first
        } catch let error as NSError {
            print(error)
            return nil
        }
    }
}








