//
//  NetworkManager.swift
//  MelchiMediaEditor
//
//  Created by SungWook Kim on 2020/08/13.
//  Copyright © 2020 richBeam. All rights reserved.
//
//
import Alamofire
import UIKit

// 네트워크 매니저
struct AlamofireManager {
    static var shared: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 20
        let sessionManager = Alamofire.Session.default
        return sessionManager
    }()
}

// default 헤더 생성
enum AlamofireHeaders {
    static func createHeader() -> [String: String] {
        return [String: String]()
    }
}

// media 헤더 생성
enum AlamofireMediaHeaders {
    static func createHeader() -> [String: String] {
        return [String: String]()
    }
}

// 인터넷이 연결되어있는지 확인
class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
enum NetworkError: Error {
    case tokenInvalid
}
// swiftlint:disable all
class NetworkManager {
    static let share = NetworkManager()

    private var reachability: NetworkReachabilityManager!
    private var session: Session!
    private(set) var token: String!
    
    private var request: DataRequest? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    func requestToken(id: String = "", passworkd: String = "",
                      completion: @escaping (Result<String, Error>) -> Void) {
        // DO Something to get token
        token = "56a52203b90209ff3b16b6b5b48ab64f"
        completion(.success(token))
    }


    func requestSong(completion: @escaping (Result<[NetworkMusicModel], Error>) -> Void) {
        if token == nil {
            completion(.failure(NetworkError.tokenInvalid))
        }
        
        request = session.request(APINetworkManager.getSongs)
        request?.responseDecodable(of: NetworkMusicModel.self){ response in
            guard let song = response.value else {
                Log.crushOrError("Fail to get songlist - [\(String(describing: response.error))] \(response)")
                return
            }
            completion(.success([song]))
        }
    }
    
    func downloadFile(url: URL, downloadURL: URL, completion: @escaping () -> Void) {
        
    }
    
    private init() {
        reachability = NetworkReachabilityManager(host: APINetworkManager.base)
        reachability.startListening { status in
            print("\(status)")
        }
        requestToken { [weak self] result in
            switch result{
            case .success(let tokenKey) :
                Log.info("get token - \(tokenKey)")
                self?.session = Session(interceptor: self)
            case .failure(let error):
                Log.info("get Error \(error)")
            }
        }
    }
}

extension NetworkManager : Alamofire.RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard token != nil else {
            completion(.failure(NetworkError.tokenInvalid))
            return
        }
        // NOTE : ADD Header for token BUT NOT OPERATED........
//        var urlRequest = urlRequest
//        urlRequest.setValue(correctToken, forHTTPHeaderField: "Authorization")
        
        completion(.success(urlRequest))
    }
}
