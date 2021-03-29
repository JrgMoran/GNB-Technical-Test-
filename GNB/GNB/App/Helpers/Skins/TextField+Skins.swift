//
//  TextField+Skins.swift
//  GNB
//
//  Created by Jorge Morán on 07/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import SkyFloatingLabelTextField
import RxCocoa

extension SkyFloatingLabelTextField {
    
    func text(_ texts: SkyTextFieldTexts, withSkin skin: TextFieldSkin){
        self.title = texts.title
        self.text = texts.text
        self.errorMessage = texts.errorText
        self.placeholder = texts.placeHolder
        self.applySkin(skin)
    }
    
    func applySkin(_ skin: TextFieldSkin){
        self.textColor = skin.textColor
        self.selectedTitleColor = skin.selectedTitleColor
        self.selectedLineColor = skin.selectedLineColor
        self.titleFormatter = { $0 }
        self.errorColor = skin.errorColor
        
        if skin.isSecureTextEntry {
            self.isSecureTextEntry = true
            setImageForPassword()
            self.addTarget(self, action: #selector(changeEditingPassword(_:)), for: .editingDidBegin)
            self.addTarget(self, action: #selector(changeEditingPassword(_:)), for: .editingDidEnd)
        }
        
    }
    
    @objc private func passwordTap() {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setImageForPassword()
    }
    
    private func setImageForPassword() {
        let imageView = UIImageView(image: ((self.isSecureTextEntry ? R.images.ico_eye_open : R.images.ico_eye_close)?
            .imageWithInsets(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)) ?? UIImage()).withRenderingMode(.alwaysTemplate))
        
        imageView.tintColor = self.isEditing ? self.selectedLineColor : self.disabledColor
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(passwordTap))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        
        self.rightView = imageView
        self.rightViewMode = .always
    }
    
    @objc private func changeEditingPassword(_ textField: UITextField) {
        setImageForPassword()
    }
}

class TextFieldSkin {
    let textColor: UIColor
    
    let selectedTitleColor: UIColor
    let selectedLineColor: UIColor
    
    let errorColor: UIColor
    
    let isSecureTextEntry: Bool
    
    let font: UIFont?
    
    init(textColor: UIColor,
         selectedTitleColor: UIColor,
         selectedLineColor: UIColor,
         errorColor: UIColor,
         isSecureTextEntry: Bool,
         font: UIFont?) {
        self.textColor = textColor
        self.selectedTitleColor = selectedTitleColor
        self.selectedLineColor = selectedLineColor
        self.errorColor = errorColor
        self.isSecureTextEntry = isSecureTextEntry
        self.font = font
    }
    
    class var defaultTextField: TextFieldSkin {
        return TextFieldSkin(textColor: UIColor.main, selectedTitleColor: .unselected, selectedLineColor: .main, errorColor: .red, isSecureTextEntry: false, font: UIFont.textFields)
    }
    
    class var secureTextField: TextFieldSkin {
        return TextFieldSkin(textColor: UIColor.main, selectedTitleColor: .unselected, selectedLineColor: .main, errorColor: .red, isSecureTextEntry: true, font: UIFont.textFields)
    }
}

struct SkyTextFieldTexts {
    let title: String?
    let errorText: String?
    let placeHolder: String?
    let text: String?
    
    init(title: String? = nil, errorText: String? = nil, placeHolder: String? = nil, text: String? = nil) {
        self.title = title
        self.errorText = errorText
        self.placeHolder = placeHolder
        self.text = text
    }
}

