//
//  Nursery.swift
//  NurseryApp
//
//  Created by Amora J. F. on 13/03/2024.
//

import Foundation

struct Nursery: Codable {
    let name: String
    let location:String
    let imageUrl:String?
    let caseId: CaseId
    let areaId: AreaId
}

struct CaseId : Codable{
    let id : Int
    let name: String
}

struct AreaId : Codable{
    let id : Int
    let name: String
}
