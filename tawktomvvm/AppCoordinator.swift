import Foundation
import UIKit

// MARK: - AppRouter Protocol
public protocol AppRouterProtocol: AnyObject {
    func start()
}


class AppCoordinator: AppRouterProtocol {
    let window: UIWindow
    var usersCoordinator: UsersCoordinator?
    
    
    // MARK: - Properties
    
//    let apiClient: ApiClient = {
//        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders = ["Content-Type": "application/json; charset=utf-8"]
//        let apiClient = ApiClient(configuration: configuration)
//        return apiClient
//    }()

    // MARK: - Coordinator
    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        showUsersViewController()
    }
    
    private func showUsersViewController() {
        usersCoordinator = UsersCoordinator.init(window: self.window)
        usersCoordinator?.start()
        window.makeKeyAndVisible()
    }

}
