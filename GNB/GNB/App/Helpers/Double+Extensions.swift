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
    
    func formatAsCurrency(currencyCode: String) -> String? {
        if let locale = Locale.from(currencyCode: currencyCode) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = Locale.current
            formatter.currencySymbol = locale.currencySymbol
            return formatter.string(from: self as NSNumber)
        }
        return nil
    }
}
