//
//  Amount.swift
//  GNB
//
//  Created by Jorge Morán on 28/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
struct Amount {
    let value: Double?
    let currency: String
    
    init(value: Double?, currency: String) {
        self.value = value
        self.currency = currency
    }
    
    init(from trade: TradeElement) {
        self.value = Double(trade.amount)
        self.currency = trade.currency
    }
    
    var formatedValue: String? {
        return value?.formatAsCurrency(currencyCode: currency)
    }
}
