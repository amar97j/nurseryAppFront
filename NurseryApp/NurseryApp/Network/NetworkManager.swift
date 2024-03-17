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
        AF.request(url, method: .post,parameters: user, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
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
    
    func fetchNurseries(token: String, completion: @escaping ([Nursery]?) -> Void) {
        
        
        let url = baseUrl + "nurseries/get_nurseries"
        let headers: HTTPHeaders = ["Authorization" : "\(token)"]
        
        AF.request(url, method: .get, headers: headers).validate().responseDecodable(of:[Nursery].self) { response in
            switch response.result {
                
            case .success(let nurseries):
                print(nurseries)
                
                completion(nurseries)
            case .failure(let error):
                
                print(error)
                completion(nil)
            }
        }
        
    }
    
    
    func registerChild(token: String, child: Child, id: Int, completion: @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = ["Authorization" : "\(token)"]
        
        AF.request(baseUrl + "child/register?userId=\(id)", method: .post, parameters: child, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            
            switch response.result {
            case .success:
                print(response.result)
                completion(true)
            case .failure(let error):
                print("POST Request Error: \(error.localizedDescription)")
                completion(false)
            }
            
        }
        
    }
    func fetchChildEnrollments(userId: Int, childId: Int, completion: @escaping (Result<[EnrollmentResponse], Error>) -> Void) {
        let url = baseUrl + "enroll/get_child_enrollment?userId=\(userId)&childId=\(childId)"
        AF.request(url, method: .get).validate().responseDecodable(of: [EnrollmentResponse].self) { response in
            switch response.result {
            case .success(let enrollments):
                completion(.success(enrollments))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchChildInfo(token:String ,userId: Int, completion: @escaping (Result<[Child], Error>) -> Void) {
        let headers: HTTPHeaders = ["Authorization" : "\(token)"]
        let url = baseUrl + "child/\(userId)"
        
        AF.request(url, method: .get).validate().responseDecodable(of: [Child].self) { response in
            switch response.result {
            case .success(let enrollments):
                // EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: \(str)")
                }
                completion(.success(enrollments))
            case .failure(let error):
                // EXTRA LINE FOR DEBUGGING
                if let data = response.data, let str = String(data: data, encoding: .utf8) {
                    print("Raw response: \(str)")
                }
                completion(.failure(error))
            }
        }
    }
    
    
    
}
