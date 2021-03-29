//
//  Error.swift
//  GNB
//
//  Created by Jorge Morán on 06/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import Foundation

enum AppError: Error, Equatable {
    //400
    case unautorized
    case notFound
    //500
    case serverError(message: String?)
    // Others
    case unknown(message: String?)
    case badJson
    case badArrayJson
    case noSelf
    
    case other(error: Error)
    
    init?(for statusCode: Int, message: String? = nil) {
        switch statusCode {
        case 200...299:
            return nil
            
        case 401:
            self = AppError.unautorized
            
        case 404:
            self = AppError.notFound
        
        case 500...599:
            self = AppError.serverError(message: message)
            
        default:
            self = AppError.unknown(message: message)
        }
        
    }
    
    static func == (lhs: AppError, rhs: AppError) -> Bool {
        let error1 = lhs as NSError?
        let error2 = rhs as NSError?
        return error1?.domain == error2?.domain
            && error1?.code == error2?.code
            && "\(lhs)" == "\(rhs)"
    }
}
