import Foundation

// MARK: - MainVC Router Protocol
public protocol UserDetailAPIServiceProtocol: AnyObject {
    func getUserDetail(name: String) async -> Result<UserDetail>
}

// MARK: - MainVCCoordinator Class
class UserDetailAPIService: UserDetailAPIServiceProtocol {
    
    func getUserDetail(name: String) async -> Result<UserDetail> {
        
        let data = await APIWorker.getUserDetail(userName: name)
        return data
        
    }
}
