//
//  User.swift
//  GNB
//
//  Created by Jorge Morán on 06/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import Foundation

struct User: Codable {
    let name: String?
    let surname: String?
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case surname = "surname"
        case email = "email"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        surname = try values.decodeIfPresent(String.self, forKey: .surname)
        email = try values.decode(String.self, forKey: .email)
    }
    
}
