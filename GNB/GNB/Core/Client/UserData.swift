//
//  UserData.swift
//  GNB
//
//  Created by Jorge Morán on 6/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import Security

protocol UserData {
    func save(value: String?, for key: UserPreferencesKey)
    func load(for key: UserPreferencesKey) -> String?
    @discardableResult
    func delete(for key: UserPreferencesKey) -> Bool
    func deleteAll()
    func deleteKeyChain()
}

protocol KeyChain {
    @discardableResult
    func save(string: String?, for key: KeyChainKeys) -> OSStatus
    @discardableResult
    func save(data: Data, for key: KeyChainKeys) -> OSStatus
    func load(for key: KeyChainKeys) -> Data?
    func loadString(for key: KeyChainKeys) -> String?
    func deleteAll()
}


enum KeyChainKeys: String {
    case user = "KeyChain_USER"
    case pass = "KeyChain_PASS"
}


enum UserPreferencesKey: CaseIterable {
    
    case biometric
    case user
    case pass
    
    init?(rawValue: String) {
        for myValue in UserPreferencesKey.allCases {
            if myValue.rawValue == rawValue {
                self = myValue
            }
        }
        return nil
    }
    
    static var allCases: [UserPreferencesKey] {
        return [.user, .pass, .biometric]
    }
    
    var rawValue: String {
        switch self {
        case .biometric:    return "Local_biometric"
        case .user:         return KeyChainKeys.user.rawValue
        case .pass:         return KeyChainKeys.pass.rawValue
            
        }
    }
    
    var mustBeKeyChain: Bool {
        return self.keychainKey != nil
    }
    
    var keychainKey: KeyChainKeys? {
        switch self {
        case .biometric:        return nil
        case .user:             return KeyChainKeys.user
        case .pass:             return KeyChainKeys.pass
        }
    }
}
