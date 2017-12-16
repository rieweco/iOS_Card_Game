
import UIKit

class DecksViewController: UIViewController {
    
    var session: ApplicationSession!
    var deckPersistence: DeckPersistence!
    var deckArray: [Deck]?


    @IBOutlet weak var deckCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deckCollectionView.delegate = self
        deckCollectionView.dataSource = self
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension DecksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let storyboard: UIStoryboard = UIStoryboard(name: "Card", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CardViewController") as! CardViewController
        vc.session = session
        session.cardPersistence.addCard(with: "ben1", icon: "ben", flipped: false, number: 1, complete: nil)
        session.cardPersistence.addCard(with: "solo1", icon: "solo", flipped: false, number: 2, complete: nil)
        session.cardPersistence.addCard(with: "leia1", icon: "leia", flipped: false, number: 3, complete: nil)
        session.cardPersistence.addCard(with: "boba1", icon: "boba", flipped: false, number: 4, complete: nil)
        session.cardPersistence.addCard(with: "c3po1", icon: "c3po", flipped: false, number: 5, complete: nil)
        session.cardPersistence.addCard(with: "chewy1", icon: "chewy", flipped: false, number: 6, complete: nil)
        session.cardPersistence.addCard(with: "luke1", icon: "luke", flipped: false, number: 7, complete: nil)
        session.cardPersistence.addCard(with: "stormtrooper1", icon: "stormtrooper", flipped: false, number: 8, complete: nil)
        session.cardPersistence.addCard(with: "vader1", icon: "vader", flipped: false, number: 9, complete: nil)
        session.cardPersistence.addCard(with: "yoda1", icon: "yoda", flipped: false, number: 10, complete: nil)
        session.cardPersistence.addCard(with: "ben2", icon: "ben", flipped: false, number: 11, complete: nil)
        session.cardPersistence.addCard(with: "solo2", icon: "solo", flipped: false, number: 12, complete: nil)
        session.cardPersistence.addCard(with: "leia2", icon: "leia", flipped: false, number: 13, complete: nil)
        session.cardPersistence.addCard(with: "boba2", icon: "boba", flipped: false, number: 14, complete: nil)
        session.cardPersistence.addCard(with: "c3po2", icon: "c3po", flipped: false, number: 15, complete: nil)
        session.cardPersistence.addCard(with: "chewy2", icon: "chewy", flipped: false, number: 16, complete: nil)
        session.cardPersistence.addCard(with: "luke2", icon: "luke", flipped: false, number: 17, complete: nil)
        session.cardPersistence.addCard(with: "stormtrooper2", icon: "stormtrooper", flipped: false, number: 18, complete: nil)
        session.cardPersistence.addCard(with: "vader2", icon: "vader", flipped: false, number: 19, complete: nil)
        session.cardPersistence.addCard(with: "yoda2", icon: "yoda", flipped: false, number: 20, complete: nil)
        vc.cardArray = session.cardPersistence.getCards()
        self.show(vc, sender: self)
    }
}

extension DecksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (deckArray?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deckCell", for: indexPath) as!  DeckCollectionViewCell
        
        let deck = deckArray![indexPath.row]
        cell.decorate(with: deck)
        
        return cell
    }
    
    
}











