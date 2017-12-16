//
//  CardViewController.swift
//  CardGame
//
//  Created by cody riewerts on 12/16/17.
//  Copyright © 2017 cody riewerts. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    var session: ApplicationSession!
    var cardPersistence: CardPersistence!
    var cardArray: [Card]?
    var cardsFlipped = 0

    @IBOutlet weak var cardCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as!  CardCollectionViewCell
        
        let card = cardArray![indexPath.row]
        session.cardPersistence.flipCard(with: Int16(indexPath.row), complete: nil)
        cardsFlipped = cardsFlipped + 1
        cell.decorate(with: card)
        collectionView.reloadData()
        
        //check flipped cards
        if cardsFlipped == cardArray?.count {
            let alertController = UIAlertController(title: "You Win!", message: "You have found all the matches!", preferredStyle: UIAlertControllerStyle.alert)
            
//            let DestructiveAction = UIAlertAction(title: "Destructive", style: UIAlertActionStyle.destructive) {
//                (result : UIAlertAction) -> Void in
//                print("Destructive")
//            }
            
            // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
            
            let okAction = UIAlertAction(title: "DONE", style: UIAlertActionStyle.default) {
                (result : UIAlertAction) -> Void in
                self.session.userPersistence.updateUserWins(with: self.session.username!)
                let storyboard: UIStoryboard = UIStoryboard(name: "UserList", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "UsersViewController") as! UsersViewController
                vc.session = self.session
                self.session.cardPersistence.resetCards(complete: nil)
                self.session.deckPersistence.resetDecks(complete: nil)
                
                self.show(vc, sender: self)
            }
            
//            alertController.addAction(DestructiveAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension CardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cardArray?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as!  CardCollectionViewCell
        
        let card = cardArray![indexPath.row]
        cell.decorate(with: card)
        
        return cell
    }
    
    
}







