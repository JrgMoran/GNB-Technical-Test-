//
//  Button+Skins.swift
//  GNB
//
//  Created by Jorge Morán on 15/08/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import UIKit

extension UIButton {
    
    func text(_ text: String?, withSkin skin: ButtonSkin) {
        self.setTitle(text, for: .normal)
        self.setTitle(text, for: .disabled)
        self.applySkin(skin)
    }
    
    func attributedText(_ attributedText: NSAttributedString, skin: ButtonSkin) {
        self.setAttributedTitle(attributedText, for: .normal)
        self.applySkin(skin)
    }
    
    func applySkin(_ skin: ButtonSkin){
        self.backgroundColor = skin.backgroundColor
        
        self.setTitleColor(skin.titleColor, for: .normal)
        
        if skin.isRounded {
            self.layer.cornerRadius = self.frame.height/2
        }
        
        self.layer.borderWidth = skin.borderWidth
        self.layer.borderColor = skin.borderColor
    }
}

class ButtonSkin {
    let backgroundColor: UIColor
    let titleColor: UIColor
    let isRounded: Bool
    let borderWidth: CGFloat
    let borderColor: CGColor
    
    init(backgroundColor: UIColor, titleColor: UIColor, isRounded: Bool, borderWidth: CGFloat, borderColor: CGColor) {
        self.backgroundColor = backgroundColor
        self.titleColor = titleColor
        self.isRounded = isRounded
        self.borderWidth = borderWidth
        self.borderColor = borderColor
       
    }
    
    class var main: ButtonSkin {
        return  ButtonSkin(backgroundColor: UIColor.main, titleColor: .white, isRounded: true, borderWidth: 0, borderColor: UIColor.clear.cgColor)
    }
    
    class var secundary: ButtonSkin {
        return ButtonSkin(backgroundColor: UIColor.clear, titleColor: .main, isRounded: true, borderWidth: 2, borderColor: UIColor.main.cgColor)
    }
}
