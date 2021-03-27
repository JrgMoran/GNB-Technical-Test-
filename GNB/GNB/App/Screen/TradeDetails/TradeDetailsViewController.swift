//
//  TradeDetailsViewController.swift
//  GNB
//
//  Created by Jorge Morán on 25/3/21.
//

import UIKit
import RxSwift
import RxCocoa

class TradeDetailsViewController: ViewController {
    
    // MARK: IBOutlet
    
    // MARK: Injections
    var viewModel: TradeDetailsViewModel!
    
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
        let input = TradeDetailsViewModel.Input(trigger: self.rx.viewWillAppear)
        let _ = viewModel.transform(input: input)
    }

}
