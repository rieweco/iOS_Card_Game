
import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var winNumberLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func decorate(with user: User) {
        usernameLabel.text = user.username
        winNumberLabel.text = String(user.wins)
    }
}
    
    


