//
//  NetworkManager.swift
//  BankApiCornerStone
//
//  Created by Amora J. F. on 11/03/2024.
//

import Foundation

import Alamofire
class NetworkManager {
    
    private let baseUrl = "http://localhost:8080/api/v1/"
    
    static let shared = NetworkManager()
    
    func signup(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseUrl + "auth/Signup"
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                // EXTRA LINE FOR DEBUGGING
          if let data = response.data, let str = String(data: data, encoding: .utf8) {
              print("Raw response: \(str)")
          }
                completion(.success(()))
            }
        }
    }
    
    func signIn(user: User, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let url = baseUrl + "auth/login"
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
                
            case .success(let value):
                // EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: \(str)")
                }
                completion(.success(value))
            case .failure(let afError):
                // EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: \(str)")
                }
                completion(.failure(afError))
            }
        }
    }
        func fetchNurseries(completion: @escaping ([Nursery]?) -> Void) {
            let endpoint = "/get_nursery"
            AF.request(baseUrl + endpoint).responseDecodable(of: [Nursery].self) { response in
                switch response.result {
                case .success(let nurseries):
                    completion(nurseries)
                case .failure(_):
                    completion(nil)
                }
            }
        }
    }

    
    
    func registerChild(child: Child, completion: @escaping (Bool) -> Void) {
        
        AF.request(baseUrl + "child/register", method: .post, parameters: child, encoder: JSONParameterEncoder.default).response { response in
            switch response.result {
                case .success:
                    completion(true)
                case .failure(let error):
                print("POST Request Error: \(error.localizedDescription)")
                                completion(false)
            }

        }

    }
    
    
}
