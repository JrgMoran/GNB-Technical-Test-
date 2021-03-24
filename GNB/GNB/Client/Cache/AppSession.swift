//
//  AppSession.swift
//  GNB
//
//  Created by Jorge Morán
//

import Foundation

class AppSession {
    static var shared: AppSession = AppSession()
    private var sessionPrivate: Session?
    
    var session: Session? {
        set(value) {
            AppSession.shared.sessionPrivate = value
        }
        get {
            return AppSession.shared.sessionPrivate
        }
    }
    
    let tokenType: String = "Bearer"
    
    func clean() {
        AppSession.shared = AppSession()
    }
}
