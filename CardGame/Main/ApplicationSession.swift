import Foundation

class ApplicationSession {
    
    let userPersistence: UserPersistence
    let deckPersistence: DeckPersistence
    let cardPersistence: CardPersistence
    
    private var _username: String?
    var username: String? {
        get { return _username }
        set {
            if !isUserLoggedIn { _username = newValue }
        }
    }
    
    init() {
        let coreDataManager = CoreDataManager()
        self.userPersistence = UserPersistence(coreDataManager: coreDataManager)
        self.deckPersistence = DeckPersistence(coreDataManager: coreDataManager)
        self.cardPersistence = CardPersistence(coreDataManager: coreDataManager)
    }
    
    private var _isUserLoggedIn: Bool = false
    var isUserLoggedIn: Bool {
        return _isUserLoggedIn
    }
    
    func attemptLogin(_ complete: (Bool) -> Void) {
        _isUserLoggedIn = true
        complete(isUserLoggedIn)
    }
}
