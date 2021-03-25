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
    
    class var titleCell: LabelSkin {
        return LabelSkin(font: UIFont.titleCell, textColor: UIColor.black, textAlignment: .left)
    }
    
    class var body: LabelSkin {
        return LabelSkin(font: UIFont.body, textColor: UIColor.black, textAlignment: .left)
    }
    
}
