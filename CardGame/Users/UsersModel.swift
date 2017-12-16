import Foundation

enum UserStatus : String{
    case inGame = "inGame",
    complete = "complete"
}

struct UserInfo {
    var username: String
    var wins: Int16
    var status: String?
    
    init(username: String, wins: Int16, status: String? = nil) {
        self.username = username
        self.wins = wins
        self.status = status
   
    }
    
    mutating func populate(from user: User) throws{
        username = user.username!
        wins = user.wins
        status = user.status
    }
    
    
}

