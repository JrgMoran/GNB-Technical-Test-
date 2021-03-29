//
//  Session.swift
//  GNB
//
//  Created by Jorge Morán on 06/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import Foundation

struct Session: Codable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decode(String.self, forKey: .token)
    }
    
}
