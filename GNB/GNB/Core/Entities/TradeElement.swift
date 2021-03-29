//
//  TradeElement.swift
//  GNB
//
//  Created by Jorge Morán on 24/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
struct TradeElement: Codable {
    let sku, amount, currency: String
    
    enum CodingKeys: String, CodingKey {
        case sku, amount, currency
    }
}


