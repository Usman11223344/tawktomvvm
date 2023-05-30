import Foundation

// MARK: - MainVC Router Protocol
public protocol UsersAPIServiceProtocol: AnyObject {
    func getUser(page: Int) async -> Result<[User]>
}

// MARK: - MainVCCoordinator Class
class UsersAPIService: UsersAPIServiceProtocol {
    
    func getUser(page: Int) async -> Result<[User]> {
        
        let data = await APIWorker.getUsers(page: "\(page)")
        return data
        
    }
}
