//
//  APIManager.swift
//  TvShow
//
//  Created by Muhammad Imran on 04/04/2022.
//

import Foundation
import UIKit

private let contentType = "application/json"

class APIManager {
    static let sharedInstance = APIManager()
    private var sessionManager = URLSession.shared
    private let baseURL: URL = URL(string: "https://api.github.com/")!
    
    private init() {
    }
    
    fileprivate func networkUnknownError() -> NetworkError {
        return NetworkError(code: NetworkError.Error.unknown.rawValue, error: .unknown)
    }
    
    private func dataRequest<T: Decodable>(for urlRequest:URLRequest, completeOn queue: DispatchQueue, completion: @escaping(Result<T>) -> Void ) {

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            print("Requesr: \(urlRequest)")
            if let error = error {
                completion(.failure("Something went wrong"))
                return
            }
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(.failure("Something went wrong"))
                return
            }
            guard let data = data else {
                completion(.failure("Something went wrong"))
                return
            }
            do {
                let decoder = JSONDecoder(context: CoreDataManager.shared.childContext)
                let object = try decoder.decode(T.self, from: data)
                completion(.success(object))
                
            } catch (let error) {
                print(error)
                completion(.failure("Something went wrong"))
            }
            
        }
        dataTask.resume()

    }
    
    func jsonToData(json: Any) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil;
    }
    
    private func urlRequest(for resource: Endpoint, language: String = "en", systemVersion: String = UIDevice.current.systemVersion) -> URLRequest? {
        return URLRequest(baseURL: self.baseURL, endpoint: resource)
        
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}

// MARK: - NetworkManager Delegates
extension APIManager: NetworkManager {
    func execute<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T>) -> Void) {
        execute(endpoint, completeOn: .main, completion: completion)
    }
    
    func execute<T: Decodable>(_ endpoint: Endpoint, completeOn queue: DispatchQueue, completion: @escaping (Result<T>) -> Void) {
        guard let apiURLRequest = self.urlRequest(for: endpoint) else {
            completion(.failure("Something went wrong"))
            return
        }
        self.dataRequest(for: apiURLRequest, completeOn: queue, completion: completion)
    }
}


