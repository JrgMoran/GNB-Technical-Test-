//
//  ViewController.swift
//  GNB
//
//  Created by Jorge Morán on 04/08/2020.
//  Copyright © 2020 Jorge Morán. All rights reserved.
//

import UIKit
import RxSwift
import RxGesture

class ViewController: UIViewController {
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: LIFE CYCLE
    deinit {
        print("- deinit: \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            self?.view.endEditing(true)
        }).disposed(by: disposeBag)
    }
    
    // MARK: NavigationController

    override var title: String? {
        didSet {
            if self.navigationBarHidden {
                self.navigationBarHidden = title == nil
            }
        }
    }
    
    var rightBarButtonItems: [UIBarButtonItem] = []{
        didSet {
            self.navigationBarHidden = false
        }
    }
    
    var navigationBarHidden: Bool = true {
        didSet {
            configurationNavigation()
            self.navigationController?.setNavigationBarHidden(navigationBarHidden, animated: false)
        }
    }
    
    func configurationNavigation() {
        
        //TITLE
        if let title = self.title ?? navigationController?.navigationBar.topItem?.title {
            let label = UILabel()
            label.text(title, withSkin: LabelSkin.body)
            self.navigationItem.titleView = label
        }
        
        // rightButtons
        self.navigationItem.rightBarButtonItems = rightBarButtonItems
    }
}

extension Reactive where Base: ViewController {
    
    var viewDidLoad: Observable<Void> {
        return sentMessage(#selector(UIViewController.viewDidLoad)).mapToVoid().asDriverOnErrorJustComplete().asObservable()
    }
    var viewWillAppear: Observable<Void> {
        return sentMessage(#selector(UIViewController.viewWillAppear(_:))).mapToVoid().asDriverOnErrorJustComplete().asObservable()
    }
    var viewDidAppear: Observable<Void> {
        return sentMessage(#selector(UIViewController.viewDidAppear(_:))).mapToVoid().asDriverOnErrorJustComplete().asObservable()
    }
    var viewWillDisappear: Observable<Void> {
        return sentMessage(#selector(UIViewController.viewWillDisappear(_:))).mapToVoid().asDriverOnErrorJustComplete().asObservable()
    }
    var viewDidDisappear: Observable<Void> {
        return sentMessage(#selector(UIViewController.viewDidDisappear(_:))).mapToVoid().asDriverOnErrorJustComplete().asObservable()
    }
}
