//
//  LoginViewController.swift
//  GNB
//
//  Created by Jorge Morán on 05/09/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SkyFloatingLabelTextField

class LoginViewController: ViewController {
    
    var viewModel: LoginViewModel!
    
    //Outlets
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var credentialsStackView: UIStackView!
    @IBOutlet weak var userTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var checkBox: CheckBox!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let input = LoginViewModel.Input(trigger: self.rx.viewWillAppear,
                                         doLogin: loginButton.rx.tap.asDriver(),
                                         doRegister: registerButton.rx.tap.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.loginEnabled.drive(loginButton.rx.isEnabled).disposed(by: disposeBag)
        
        (userTextField.rx.textInput <-> viewModel.user).disposed(by: disposeBag)
        (passTextField.rx.textInput <-> viewModel.password).disposed(by: disposeBag)
        (checkBox.rx.isCheck <-> viewModel.rememberPassword).disposed(by: disposeBag)
    }
    
    private func configureView() {
        title = nil
        titleLabel.text(R.text.login_title, withSkin: .mainTitle)
        loginButton.text(R.text.access, withSkin: .main)
        registerButton.text(R.text.register, withSkin: .secundary)
        
        userTextField.text(SkyTextFieldTexts(title: R.text.user,
                                             placeHolder: R.text.user_placeholder),
                           withSkin: .defaultTextField)
        
        passTextField.text(SkyTextFieldTexts(title: R.text.password,
                                             placeHolder: R.text.password_placeholder),
                           withSkin: .secureTextField)
        
        checkBox.label.text(R.text.password_remenber, withSkin: .body)
    }

}
