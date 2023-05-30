import UIKit
import Combine

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userDetailLabel: UILabel!
    @IBOutlet weak var noteImageView: UIImageView!
    private var cancellable: AnyCancellable?
    static let identifier = "UserTableViewCell"
    static var nib: UINib? {
        UINib(nibName: "UserTableViewCell", bundle: Bundle.main)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func showData(user: User) {
        
        userNameLabel.text = user.login
        userDetailLabel.text = user.notes
        noteImageView.isHidden = ( user.notes  == nil) ? true : false
        cancellable = loadImage(for: user).sink { [unowned self] image in self.showImage(image: image) }
        
    }
    
    private func showImage(image: UIImage?) {
        userImageView.image = image
    }
    
    private func loadImage(for user: User) -> AnyPublisher<UIImage?, Never> {
        return Just(user.avatarURL )
        .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
            let url = URL(string: user.avatarURL ?? "")!
            return ImageLoader.shared.loadImage(from: url)
        })
        .eraseToAnyPublisher()
    }
    
}
