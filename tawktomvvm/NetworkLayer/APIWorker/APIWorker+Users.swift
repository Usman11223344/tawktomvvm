import Foundation


extension APIWorker{
    
    static func getUsers(page:String) async -> Result<[User]> {

        let endPoint = APIEndPoint.Users.users(page: page).endPoint
        return await withCheckedContinuation({ continuation in
            APIManager.sharedInstance.execute(endPoint) { (response: Result<[User]>) in
                CoreDataManager.shared.saveContext()
                continuation.resume(returning: response)
            }
        })
        
    }
    
}
