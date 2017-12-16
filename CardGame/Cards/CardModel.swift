

import Foundation

struct CardInfo {
    var flipped: Bool
    var name: String?
    var icon: String?
    var number: Int16
    
    init(name: String, icon: String, number: Int16, flipped: Bool = false) {
        self.name = name
        self.icon = icon
        self.number = number
        self.flipped = flipped
        
    }
    
    mutating func populate(from card: Card) throws{
        name = card.name!
        icon = card.icon!
        number = card.number
        flipped = card.flipped
    }
    
    
}
