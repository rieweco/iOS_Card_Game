import UIKit

class UsersViewController: UIViewController {
    
    var session: ApplicationSession!
    var userPersistence: UserPersistence!
    var userArray: [User]?

    @IBOutlet weak var usersTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.delegate = self
        usersTableView.dataSource = self
        
        userArray = session.userPersistence.getTheUsers()


        usersTableView.rowHeight = 100
        usersTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UsersTableViewCell
        
        let user = userArray![indexPath.row]
        cell?.backgroundColor = .yellow
        
        cell?.decorate(with: user)
        
        return cell!
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let user = userArray![indexPath.row]
        session.username = user.username
        let storyboard: UIStoryboard = UIStoryboard(name: "DecksStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DecksViewController") as! DecksViewController
        vc.session = session
        session.deckPersistence.addDeck(with: "BEN", icon: "ben", status: "complete", complete: nil)
        session.deckPersistence.addDeck(with: "YODA", icon: "yoda", status: "complete", complete: nil)
        session.deckPersistence.addDeck(with: "TROOPER", icon: "stormtrooper", status: "complete", complete: nil)
        vc.deckArray = session.deckPersistence.getDecks()
        self.show(vc, sender: self)
    }
    
}













