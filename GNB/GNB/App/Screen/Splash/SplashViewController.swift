//
//  SplashViewController.swift
//  GNB
//
//  Created by Jorge Morán on 10/3/21.
//

import UIKit
import RxSwift
import RxCocoa

class SplashViewController: ViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var imageView: UIImageView!{
        didSet {
            imageView.image = R.images.gNB_logo
        }
    }
    
    // MARK: Injections
    var viewModel: SplashViewModel!
    
    // MARK: Attributes

    // MARK: View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }

    // MARK: Configure View
    private func configureView(){
        
    }
    
    // MARK: Binding
    private func bindViewModel() {
        assert(viewModel != nil)
        let input = SplashViewModel.Input(trigger: rx.viewDidAppear)
        let _ = viewModel.transform(input: input)
    }

}
