//
//  CardCollectionViewCell.swift
//  CardGame
//
//  Created by cody riewerts on 12/16/17.
//  Copyright © 2017 cody riewerts. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
    func decorate(with card: Card) {
        if card.flipped {
            iconImage.image = UIImage(named: card.icon!)
            cardView.backgroundColor = .yellow
        } else {
            iconImage.image = UIImage(named: "title")
            cardView.backgroundColor = .white
            
        }

    }
    
}
