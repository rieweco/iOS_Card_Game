
import Foundation

struct DeckInfo {
    var title: String
    var status: String?
    var icon: String?

    
    init(title: String, status: String = "complete", icon: String) {
        self.title = title
        self.status = status
        self.icon = icon
        
    }
    
    mutating func populate(from deck: Deck) throws{
        title = deck.title!
        status = deck.status!
        icon = deck.icon!
    }
    
    
}
