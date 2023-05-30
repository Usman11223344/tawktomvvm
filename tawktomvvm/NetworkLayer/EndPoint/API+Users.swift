import Foundation

extension APIEndPoint {
   
    
    enum Users {
        
        case users(page: String)
        
        var endPoint: Endpoint {
            
            switch self {
            case .users(let page):
                return APIEndPoint(method: .get, resourcePath: "users", parameters: ["since": "\(page)"])
            }
        }
    }
}
