import Foundation

public protocol UserDetailViewModelViewDelegate: AnyObject {
    func updateScreen()
    func showError(error: String)
    func showIndicator()
    func hideIndicator()
}

public protocol UserDetailViewModelCoordinatorDelegate: AnyObject {
    
    func updateUserWithNote(note: String, forUser: User)
}



class UserDetailViewModel {

    // MARK: - Delegates
    weak var coordinatorDelegate: UserDetailViewModelCoordinatorDelegate?

    weak var viewDelegate: UserDetailViewModelViewDelegate?

    // MARK: - Properties
    fileprivate let service: UserDetailAPIServiceProtocol
    fileprivate let coordinator: UserDetailCoordinatorProtocol
    fileprivate var user: User
    fileprivate var userDetail: UserDetail?
    
    var userName: String {
        "Name: \(userDetail?.login ?? "")"
    }
    
    var followers: String {
        "Followers: \(userDetail?.followers ?? 0)"
    }
    
    var followings: String {
        "Followings: \(userDetail?.following ?? 0)"
    }
    
    var compnay: String {
        "Company: \(userDetail?.company ?? "")"
    }
    
    var blog: String {
        "Blog: \(userDetail?.blog ?? "")"
    }
    
    var userAvatarUrl: URL? {
        URL(string: userDetail?.avatarURL ?? "")
    }
    
    var notes: String? {
        user.notes
    }

    // MARK: - Init
    init(service: UserDetailAPIServiceProtocol, coordinator: UserDetailCoordinatorProtocol, user: User) {
        self.service = service
        self.coordinator = coordinator
        self.user = user
    }

    // MARK: - Network
    
    func getUserDetail() {
        
        Task {
            let result =  await service.getUserDetail(name: user.login ?? "")
            switch result {
            case .success(let detail):
                self.userDetail = detail
                DispatchQueue.main.async {
                    self.viewDelegate?.hideIndicator()
                    self.viewDelegate?.updateScreen()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.viewDelegate?.hideIndicator()
                    self.viewDelegate?.showError(error: error)
                }
            }
            DispatchQueue.main.async {
                self.viewDelegate?.updateScreen()
            }
        }
        
    }
    
    func updateNotes(note: String) {
        coordinatorDelegate?.updateUserWithNote(note: note, forUser: user)
    }
}

