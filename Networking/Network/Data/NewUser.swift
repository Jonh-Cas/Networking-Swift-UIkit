//
//  NewUser.swift
//  Networking
//
//  Created by Jonathan Casillas on 05/10/23.
//

import Foundation


struct NewUser: Encodable {
    let name: String?
    let email: String?
    let gender: String?
    let status: String?
}
