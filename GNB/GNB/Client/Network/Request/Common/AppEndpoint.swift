//
//  Endpoint.swift
//  GNB
//
//  Created by Jorge Morán
//

import Foundation

enum AppEndpoint {
    case login
    case rates
    case transaction
    
    var path: String {
        switch self {
        case .login: return "session"
        case .rates: return "rates.json"
        case .transaction: return "transactions.json"
        }
    }
    
    var url: URL? {
        let urlBase: String?
        
        switch self {
        case .login:
            urlBase = AppEnvironment.shared.urlBase
        default:
            urlBase = AppEnvironment.shared.urlClientBase
        }
        
        return URL(string: "\(urlBase ?? "")\(self.path)")
    }
}
