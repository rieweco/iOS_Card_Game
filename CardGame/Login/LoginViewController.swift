
import UIKit

protocol LoginViewControllerDelegate: class {
    func createButtonPressed()
    func userNameUpdated(to username: String)
}

class LoginViewController: UIViewController {
    
    var session = ApplicationSession()
    

    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UITextFieldTextDidChange, object: userNameTextField, queue: nil, using: textFieldTextChanged(_:))
        userNameTextField.delegate = self
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)])
        createButton.isEnabled = false

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        session.userPersistence.addUser(with: userNameTextField.text!,  complete: nil)
        delegate?.createButtonPressed()
        let storyboard: UIStoryboard = UIStoryboard(name: "UserList", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UsersViewController") as! UsersViewController
        vc.session = session
        self.show(vc, sender: self)
        
        

    }
    
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldTextChanged(_ notification: Notification) {
        let textField = notification.object as! UITextField
        if let text = textField.text {
            createButton.isEnabled = text.count > 2
        }
        delegate?.userNameUpdated(to: textField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if createButton.isEnabled {
            textField.resignFirstResponder()
            delegate?.createButtonPressed()
        }
        return true
    }
}










