import UIKit
import Combine


class UserDetailViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingsLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var indicatorView: UIView!
    
    private var cancellable: AnyCancellable?
    
    

    
    // MARK: - Properties
    var viewModel: UserDetailViewModel! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getUserDetail()
    }
    
    func updateUI() {
        userNameLabel.text = viewModel.userName
        followersLabel.text = viewModel.followers
        followingsLabel.text = viewModel.followings
        companyLabel.text = viewModel.compnay
        blogLabel.text = viewModel.blog
        notesTextView.text = viewModel.notes
        
        guard let url = viewModel.userAvatarUrl else { return }
        cancellable = loadImage(for: url).sink { [unowned self] image in self.showImage(image: image) }
    }
    
    private func showImage(image: UIImage?) {
        avatarImageView.image = image
    }
    
    private func loadImage(for userAvatarUrl: URL) -> AnyPublisher<UIImage?, Never> {
        return Just(userAvatarUrl)
        .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
            return ImageLoader.shared.loadImage(from: userAvatarUrl)
        })
        .eraseToAnyPublisher()
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        
        guard let note = notesTextView.text, note.count > 0 else {
            return
        }
        viewModel.updateNotes(note: note)
        self.navigationController?.popViewController(animated: true)
    }
}

extension UserDetailViewController: UserDetailViewModelViewDelegate {
    func updateScreen() {
        updateUI()
    }
    func showError(error: String) {
        self.showAlert(title: "Error", message: error)
    }
    
    func showIndicator() {
        indicatorView.isHidden = false
    }
    
    func hideIndicator() {
        indicatorView.isHidden = true
    }
}
