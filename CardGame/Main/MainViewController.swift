import UIKit

class MainViewController: UIViewController {

    let session = ApplicationSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        

        
    

    @IBAction func LanuchButtonPressed(_ sender: Any) {
        if session.isUserLoggedIn {
            let storyboard: UIStoryboard = UIStoryboard(name: "UserList", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "UsersViewController") as! UsersViewController
            vc.session = session
            self.show(vc, sender: self)
        }
        else {
            //performSegue(withIdentifier: "LoginSegue", sender: self)
            let storyboard: UIStoryboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            vc.session = session
            self.show(vc, sender: self)
        }
    }
    


}

extension MainViewController: LoginViewControllerDelegate {
    func userNameUpdated(to username: String) {
        session.username = username
        session.userPersistence.addUser(with: username, complete: nil)
    }
    
    func createButtonPressed() {
        session.attemptLogin { success in
            if success {
                print("great!!!!!!!!!!!!!!!!!!!!")
                
            }
        }
    }
}

