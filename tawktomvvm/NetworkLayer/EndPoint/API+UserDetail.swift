import Foundation

extension APIEndPoint {
   
    
    enum UserDetail {
        
        case userDetail(userName: String)
        
        var endPoint: Endpoint {
            
            switch self {
            case .userDetail(let userName):
                return APIEndPoint(method: .get, resourcePath: "users/\(userName)")
            }
        }
    }
}
