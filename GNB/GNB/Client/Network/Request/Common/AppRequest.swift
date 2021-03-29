//
//  Request.swift
//  GNB
//
//  Created by Jorge Morán on 11/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import Foundation

enum AppRequestMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case options = "OPTIONS"
    case head    = "HEAD"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

protocol AppRequest {
    var request: URLRequest { get }
    var endpoint: AppEndpoint { get }
    var method: AppRequestMethod { get }
    var body: [String: Any]? { get }
    var urlParams: [String: String]? { get }
    var headers: [String: String] { get }
}

extension AppRequest {
    var headers: [String: String] {
        
        if let session = AppSession.shared.session {
            return ["Content-Type": "application/json",
                    "Authorization": "\(AppSession.shared.tokenType) \(session.token)"]
        } else {
            return ["Content-Type": "application/json"]
        }
    }
    
    var body: [String: Any]? { return nil }
    
    var urlParams: [String: String]? { return nil }
    
    var request: URLRequest {
        var urlRequest = URLRequest(url: self.endpoint.url!)
        
        for header in self.headers {
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        urlRequest.httpMethod = self.method.rawValue
        switch self.method {
        case .get:
            addUrlParameters(in: &urlRequest)
        case .post:
            addUrlParameters(in: &urlRequest)
            addBody(toRequest: &urlRequest)
        default:
            // TODO: config other methods
            break
        }
        return urlRequest
    }
    
    func addUrlParameters(in request: inout URLRequest) {
        if let parameters = urlParams {
            let params = parameters.map { "\(escape($0))=\(escape($1))" }.joined(separator: "&")
            request.url = URL(string: self.endpoint.url!.absoluteString + "?" + params)!
        }
    }
    
    public func addBody(toRequest: inout URLRequest) {
        toRequest.httpBody = try? paramsAsJSONBody()
    }
    
    private func paramsAsJSONBody() throws -> Data? {
        if let paramsUnwrapped = self.body {
            do {
                return try JSONSerialization.data(withJSONObject: paramsUnwrapped)
            }
        }
        return nil
    }
    
    private func escape(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@/"
        let subDelimitersToEncode = "!$&'()*+,;="
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
    }
}
