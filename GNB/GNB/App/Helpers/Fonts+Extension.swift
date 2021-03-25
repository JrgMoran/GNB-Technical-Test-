//
//  Fonts.swift
//  GNB
//
//  Created by Jorge Morán on 07/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import Foundation
import UIKit

//Montserrat
extension UIFont {
    
    /**
    return Montserrat-Bold size 24
    */
    class var mainTitle: UIFont? {
        return UIFont(name: "Montserrat-Bold", size: 24)
    }
    
    /**
    return Montserrat-Bold size 24
    */
    class var titleCell: UIFont? {
        return UIFont(name: "Montserrat-Bold", size: 16)
    }
    
    /**
    return Montserrat-Regular size 16
    */
    class var body: UIFont? {
        return UIFont(name: "Montserrat-Regular", size: 16)
    }
    
    /**
    return Montserrat-Regular size 16
    */
    class var textFields: UIFont? {
        return UIFont(name: "Montserrat-Regular", size: 16)
    }
    
    /**
    return Montserrat-Light size 16
    */
    class var lightLitle: UIFont? {
        return UIFont(name: "Montserrat-Light", size: 12)
    }
}
