//
//  DeckCollectionViewCell.swift
//  CardGame
//
//  Created by cody riewerts on 12/15/17.
//  Copyright © 2017 cody riewerts. All rights reserved.
//

import UIKit

class DeckCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var deckImage: UIImageView!
    @IBOutlet weak var deckTitle: UILabel!
    
    func decorate(with deck: Deck) {
        
        deckImage.image = UIImage(named: deck.icon!)
        deckTitle.text = deck.title
    }
    
}
