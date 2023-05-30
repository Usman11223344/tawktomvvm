import UIKit
import IQKeyboardManagerSwift



class UsersViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var indicatorView: UIView!
    let refreshControl = UIRefreshControl()
    lazy var searchBar:UISearchBar = UISearchBar()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UserTableViewCell.nib, forCellReuseIdentifier: UserTableViewCell.identifier)
            tableView.keyboardDismissMode = .onDrag
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    // MARK: - Properties
    var viewModel: UsersViewModel! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        addSearchBar()
        viewModel?.start()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    // MARK: - Helping Methods
    
    func addRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController

    }
    
    func addSearchBar() {
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.showsCancelButton = true
        searchBar.returnKeyType = .search
        searchBar.delegate = self
//        searchBar.shouldResignOnTouchOutsideMode = .enabled
        searchBar.shouldResignOnTouchOutsideMode = .default
        
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("Search", for: .normal)
//            cancelButton.setTitle(<your_string>, for: <UIControlState>)
//            cancelButton.setTitleColor(<your_uicolor>, for: <UIControlState>)
//            cancelButton.setAttributedTitle(<your_nsattributedstring>, for: <UIControlState>)
        }
        navigationItem.titleView = searchBar
    }
    // MARK: - Actions
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.refresh()
    }
}

extension UsersViewController: UsersViewModelViewDelegate {
    
    func updateScreen() {
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    func showIndicator() {
        indicatorView.isHidden = false
    }
    
    func hideIndicator() {
        indicatorView.isHidden = true
    }
    
    func showError(error: String) {
        self.showAlert(title: "Error", message: error)
    }

}

extension UsersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(indexPath.row, from: self)
    }
    
}

extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserTableViewCell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier) as! UserTableViewCell
        cell.showData(user: viewModel.itemFor(row: indexPath.row))
        
        if self.viewModel.numberOfItems() - 1 == indexPath.row {
            viewModel.nextPage()
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
    
}

extension UsersViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        print("searchBarTextDidBeginEditing")
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        print("searchBarTextDidEndEditing")
        
    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        guard textSearched.count > 0 else {
            viewModel.clearSearch()
            return
        }
        viewModel.enableSearch()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text.count > 0 else {
            return
        }
        viewModel.searchFor(text: text)
        
    }
    
}


extension UsersViewController: UserDetailViewModelCoordinatorDelegate {
    
    func updateUserWithNote(note: String, forUser user: User) {
        viewModel.updateUserNote(note: note, user: user)
        tableView.reloadData()
    }
}
