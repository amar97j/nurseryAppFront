//
//  Child.swift
//  NurseryApp
//
//  Created by Amora J. F. on 11/03/2024.
//

import Foundation
struct Child: Codable {
    let name: String
    let age: String
    let caseId: [ChildCaseId]
}

struct ChildCaseId : Codable{
    let id : Int
    let name: String
}
