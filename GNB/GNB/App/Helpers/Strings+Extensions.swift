//
//  Strings+Extensions.swift
//  GNB
//
//  Created by Jorge Morán on 12/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import Foundation
extension String {
    // TODO: extension date formatter
    var date: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from:self)
    }
}
