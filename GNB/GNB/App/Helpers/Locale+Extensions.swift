//
//  Locale+Extensions.swift
//  GNB
//
//  Created by Jorge Morán on 28/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation

extension Locale {
    private static let locales = Locale.availableIdentifiers.map(Locale.init)
    
    static func from(currencyCode: String) ->Locale? {
        let posibleLocales = self.locales.filter { $0.currencyCode == currencyCode }
        return posibleLocales.first
    }

}
