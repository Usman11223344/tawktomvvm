import Foundation
import UIKit

// MARK: - MainVC Router Protocol
public protocol UsersCoordinatorProtocol: AnyObject {
    func start()
    func showUserDetailViewConroller(from: UIViewController, detail: User)
}

// MARK: - MainVCCoordinator Class
class UsersCoordinator {
    
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - Routing
extension UsersCoordinator: UsersCoordinatorProtocol {
    
    func start() {
        let viewModel = UsersViewModel(service: UsersAPIService(), coordinator: self)
        let viewController = UsersViewController.initiateFrom(Storybaord: .main)
        viewController.viewModel = viewModel
        self.window.rootViewController = UINavigationController(rootViewController: viewController)
    }
    
    func showUserDetailViewConroller(from: UIViewController, detail: User) {
        let coordinator = UserDetailCoordinator(window: self.window)
        coordinator.show(from: from, for: detail)
    }
}
