//
//  UserDataImpl.swift
//  GNB
//
//  Created by Jorge Morán on 6/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
class UserDataImpl: UserData {
    
    let keyChain: KeyChain?
    
    init(keyChain: KeyChain? = nil) {
        self.keyChain = keyChain
    }
    
    func save(value: String?, for key: UserPreferencesKey) {
        if let keyForKeyChain = key.keychainKey, let value = value {
            keyChain?.save(string: value, for: keyForKeyChain)
        
        } else {
            let defaults = UserDefaults.standard
            defaults.set(value, forKey: key.rawValue)
        }
    }
    
    func load(for key: UserPreferencesKey) -> String? {
        if let keyForKeyChain = key.keychainKey {
            return keyChain?.loadString(for: keyForKeyChain)
        
        } else {
            let defaults = UserDefaults.standard
            return defaults.string(forKey: key.rawValue)
        }
        
    }
    
    @discardableResult
    func delete(for key: UserPreferencesKey) -> Bool {
        if !key.mustBeKeyChain {
            self.save(value: nil, for: key)
            return load(for: key) == nil
        }
        return false
    }
    
    func deleteAll() {
        self.deleteKeyChain()
        for key in UserPreferencesKey.allCases {
            self.delete(for: key)
        }
    }
    
    func deleteKeyChain() {
        keyChain?.deleteAll()
    }
    
}
