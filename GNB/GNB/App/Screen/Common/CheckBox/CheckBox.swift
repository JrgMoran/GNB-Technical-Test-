//
//  CheckBox.swift
//  GNB
//
//  Created by Jorge Morán on 19/08/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CheckBox: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak private var imageView: UIImageView!
    
    fileprivate let rxCheck:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    var isOn: Bool = false {
        didSet {
            if isOn {
                imageView.image = R.images.checkBoxOn?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = .main
            }
            else {
                imageView.image = R.images.checkBoxOff?.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = .main
            }
            rxCheck.accept(isOn)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("CheckBox", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        configureView()
    }
    
    func configureView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(checkTap))
        
        self.addGestureRecognizer(tap)
        isOn = false
    }
    
    @objc func checkTap() {
        isOn = !isOn
    }

}

extension Reactive where Base: CheckBox {
    
    var isCheck:BehaviorRelay<Bool> {
        return base.rxCheck
    }
}
