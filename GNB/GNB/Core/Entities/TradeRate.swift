//
//  Trade.swift
//  GNB
//
//  Created by Jorge Morán on 24/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
struct TradeRate: Codable {
    let from, to, rate: String
    
    enum CodingKeys: String, CodingKey {
        case from, to, rate
    }
}
