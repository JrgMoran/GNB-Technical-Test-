//
//  Downloader.swift
//  GNB
//
//  Created by Jorge Morán on 06/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import Foundation

class Downloader {
    
    let LIMIT_DATA_LOG: Int = 500
    
    lazy var session: URLSession = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
    
    var sessionConfig: URLSessionConfiguration {
        get {
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 60.0
            config.timeoutIntervalForResource = 60.0
            return config
        }
    }
    
    func execute(with request: URLRequest, completion: @escaping (_ response: Result<Data,AppError>) -> Void) {
       session.dataTask(with: request) {[weak self] data, response, error in
        
        print("🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐🌐")
        print("🌐 \(request.httpMethod ?? "") URL: \(String(request.url?.absoluteString ?? ""))")
        print("🌐 Body: \(String(decoding: request.httpBody ?? Data(), as: UTF8.self))")
        if let httpResponse = response as? HTTPURLResponse {
            print("🌐 Status: \(httpResponse.statusCode))")
        }
        print("🌐 HEADER: \(String(describing: request.allHTTPHeaderFields))")
        if let data = data {
            print("🌐 DATA RESPONSE: \n \(String(data: data, encoding: .utf8)?.prefix(self?.LIMIT_DATA_LOG ?? 500))")
        } else {
            print("🌐 NO DATA RESPONSE")
        }
        
        
        if let error = error {
            print("🌐 Error: \(String(error.localizedDescription))")
            if let httpResponse = response as? HTTPURLResponse {
                if let error = AppError(for: httpResponse.statusCode, message: String(error.localizedDescription)) {
                    completion(Result.failure(error))
                    return
                }
            } else {
                completion(Result.failure(AppError.unknown(message: error.localizedDescription)))
                return
            }
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode > 299 || httpResponse.statusCode < 199 {
                completion(Result.failure(AppError(for: httpResponse.statusCode) ?? AppError.unknown(message: nil)))
                return
            }
        }
        
        if let data = data {
            print(String(decoding: data, as: UTF8.self))
            completion(Result.success(data))
            return
        }
        }.resume()
    }

}
