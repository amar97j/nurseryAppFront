//
//  TokenResponce.swift
//  BankApiCornerStone
//
//  Created by Amora J. F. on 11/03/2024.
//


import Foundation

struct TokenResponse: Codable {
    let id: Int?
    let token: String
    let username: String
    let role: String
}


//struct SignUpResponse: Codable {
//    
//    let resposne: String
//    
//}


