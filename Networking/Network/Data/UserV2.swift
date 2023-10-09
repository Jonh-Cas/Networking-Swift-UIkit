//
//  User.swift
//  Networking
//
//  Created by Jonathan Casillas on 03/10/23.
//

import Foundation


struct UserResponseV2: Decodable {
    let UserList: [ UserV2 ]
}

struct UserV2: Decodable {
    let id: Int?
    let userId: Int?
    let title: String?
    let body: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case title
        case body
    }
    
}
