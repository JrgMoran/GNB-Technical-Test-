//
//  Environment.swift
//  GNB
//
//  Created by Jorge Morán on 11/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import Foundation

public enum Schemes: String {
    case production = "PRO"
    case mock = "MOCK"
    case dev = "DEV"
    
    init?(string: String?) {
        guard let string = string else { return nil }
        switch string.uppercased() {
        case Schemes.production.rawValue:   self = .production
        case Schemes.mock.rawValue:         self = .mock
        default: return nil
        }
    }
}

public struct AppEnvironment {
    
    static let shared: AppEnvironment = AppEnvironment()
    
    public var scheme: Schemes {
        get {
            #if DEV
                return Schemes.dev
            #elseif PRO
                return Schemes.production
            #else
                return Schemes.mock
            #endif
        }
    }
    
    public var urlBase: String? {
        get {
            switch scheme {
            case .production:
                return "https://private-0e425-urlmock.apiary-mock.com/"
            case .mock:
                return ""
            case .dev:
                return "https://private-0e425-urlmock.apiary-mock.com/"
            }
        }
    }
    
    public var urlClientBase: String? {
        get {
            switch scheme {
            case .production:
                return "http://quiet-stone-2094.herokuapp.com/"
            case .mock:
                return ""
            case .dev:
                return "http://quiet-stone-2094.herokuapp.com/"
            }
        }
    }
}
