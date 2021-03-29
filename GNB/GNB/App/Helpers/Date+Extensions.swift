//
//  Date+Extensions.swift
//  GNB
//
//  Created by Jorge Morán on 12/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import Foundation
extension Date {
    // TODO: extension date formatter
    var appDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MMM/yyyy HH:MM"
        return formatter.string(from: self)
    }
}
