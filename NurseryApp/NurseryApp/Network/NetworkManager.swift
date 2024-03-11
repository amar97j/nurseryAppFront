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
    
    func signup(user: User, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let url = baseUrl + "auth/Signup"
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
    
    func signIn(user: User, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let url = baseUrl + "auth/login"
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let afError):
                completion(.failure(afError))
            }
        }
    }
    
    
}
