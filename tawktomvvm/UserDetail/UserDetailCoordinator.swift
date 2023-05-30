import Foundation
import UIKit


// MARK: - MainVC Router Protocol
public protocol UserDetailCoordinatorProtocol: AnyObject {
    func show(from: UIViewController, for user: User)
}

// MARK: - MainVCCoordinator Class
class UserDetailCoordinator {
    
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - Routing
extension UserDetailCoordinator: UserDetailCoordinatorProtocol {
    
    func show(from: UIViewController, for user: User) {
        let viewModel = UserDetailViewModel(service: UserDetailAPIService(), coordinator: self, user: user)
        viewModel.coordinatorDelegate = from as? any UserDetailViewModelCoordinatorDelegate
        let viewController = UserDetailViewController.initiateFrom(Storybaord: .main)
        viewController.viewModel = viewModel
        from.navigationController?.pushViewController(viewController, animated: true)
    }
}
