//
//  Label+Skins.swift
//  GNB
//
//  Created by Jorge Morán on 07/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import UIKit

extension UILabel {
     
    func text(_ text: String?, withSkin skin: LabelSkin, numberOfLines: Int = 0){
        self.text = text
        self.applySkin(skin)
    }
    
    func applySkin(_ skin: LabelSkin, numberOfLines: Int = 0){
        if let font = skin.font {
          self.font = font
        }
        self.textAlignment = skin.textAlignment
        self.textColor = skin.textColor
        self.numberOfLines = numberOfLines
    }
}

class LabelSkin {
    let font: UIFont?
    let textColor: UIColor
    let textAlignment: NSTextAlignment
    
    init(font: UIFont?, textColor: UIColor, textAlignment: NSTextAlignment) {
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
    }
    
    class var mainTitle: LabelSkin {
        return LabelSkin(font: UIFont.mainTitle, textColor: UIColor.main, textAlignment: .center)
    }
    
    class var body: LabelSkin {
        return LabelSkin(font: UIFont.body, textColor: UIColor.black, textAlignment: .left)
    }
    
    class var date: LabelSkin {
        return LabelSkin(font: UIFont.lightLitle, textColor: UIColor.lightGray, textAlignment: .left)
    }
    
    class var positiveFee: LabelSkin {
        return LabelSkin(font: UIFont.lightLitle, textColor: UIColor.green, textAlignment: .left)
    }
    
    class var negativeFee: LabelSkin {
        return LabelSkin(font: UIFont.lightLitle, textColor: UIColor.red, textAlignment: .left)
    }
    
    class var positiveAmount: LabelSkin {
        return LabelSkin(font: UIFont.body, textColor: UIColor.green, textAlignment: .left)
    }
    
    class var negativeAmount: LabelSkin {
        return LabelSkin(font: UIFont.body, textColor: UIColor.red, textAlignment: .left)
    }
    
}
