//
//  KeyChainImpl.swift
//  GNB
//
//  Created by Jorge Morán on 6/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation
import Security
class KeyChainImpl: KeyChain {
    func save(string: String?, for key: KeyChainKeys) -> OSStatus {
        if let data = string?.data(using: .utf8){
            return save(data: data, for: key)
        }

        return -50      //errSecParam
    }
    
    func save(data: Data, for key: KeyChainKeys) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key.rawValue,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }
    
    func load(for key: KeyChainKeys) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key.rawValue,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }
    
    func loadString(for key: KeyChainKeys) -> String? {
        guard let data = load(for: key),
              let text = String(data: data, encoding: .utf8) else { return nil }
        return text
    }

    func deleteAll() {
        let secItemClasses = [kSecClassGenericPassword, kSecClassInternetPassword, kSecClassCertificate, kSecClassKey, kSecClassIdentity]
        secItemClasses.forEach { (itemClass) in
            let spec: NSDictionary = [kSecClass: itemClass]
            SecItemDelete(spec)
        }
    }

    func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)

        let swiftString: String = cfStr as String
        return swiftString
    }
    
}
