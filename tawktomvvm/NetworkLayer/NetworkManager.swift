//
//  NetworkManager.swift
//  TvShow
//
//  Created by Muhammad Imran on 18/05/2022.
//

import Foundation

public struct NetworkError {
    
    var code: Int?
    var error: Error?
    
    enum Error: Int {
        case badRequest = 400
        case unknown
        
        var description: String {
            switch self {
            case .badRequest:
                return "Bad request"
            case .unknown:
                return "Something went wrong"
            }
        }
    }
}

public enum StatelessResult {
    case success
    case failure(Error)
}

/// Used mostly in the async retrieval of data, as the first parameter of a closure.
///
/// - `success` will contain the data that was retrieved.
/// - `failure` will contain an error with details about the failure.
public enum Result<T> {
    case success(T)
    case failure(String)
}

/// Used mostly in the async retrieval of data, as the first parameter of a closure.
/// Also contains previously cached data in case of a failure.
///
/// - `success` will contain the data that was retrieved.
/// - `failure` will contain an error with details about the failure, and may
/// contain previously cached data where applicable.
public enum UpdateResult<T> {
    case success(T)
    case failure(Error, T?)
}

typealias NetworkManagerResultHandler<T: Decodable> = (Result<T>) -> Void
typealias ConnectionObserverHandler = (ConnectionState) -> Void
typealias ProgressHandler = (Float) -> Void
typealias DownloadResultHandler = (Result<URL>) -> Void

/// Used execute async HTTP requests

enum ConnectionState {
    case unkown
    case reachable
    case unreachable
}

protocol ConnectionObserver {
    var connectionState: ConnectionState { get }
    var connectionObserverHandler: ConnectionObserverHandler? { get set }
}

protocol NetworkManager {
    
    func execute<T: Decodable>(_ endpoint: Endpoint, completion: @escaping NetworkManagerResultHandler<T>)
    func execute<T: Decodable>(_ endpoint: Endpoint, completeOn queue: DispatchQueue , completion: @escaping NetworkManagerResultHandler<T>)
}
