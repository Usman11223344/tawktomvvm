import Foundation

extension APIWorker{
    
    static func getUserDetail(userName:String) async -> Result<UserDetail> {
        
        let endPoint = APIEndPoint.UserDetail.userDetail(userName: userName).endPoint
        return await withCheckedContinuation({ continuation in
            APIManager.sharedInstance.execute(endPoint) { (response: Result<UserDetail>) in
                continuation.resume(returning: response)
            }
        })
        
    }
    
}
