//
//  Double+Extensions.swift
//  GNB
//
//  Created by Jorge Morán on 12/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import Foundation
extension Double {
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
    
    func formatAsCurrency(currencyCode: String = Locale.current.currencyCode ?? "EUR") -> String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencyCode = currencyCode
        currencyFormatter.maximumFractionDigits = floor(self) == self ? 0 : 2
        return currencyFormatter.string(from: NSNumber(value: self))
    }
}
