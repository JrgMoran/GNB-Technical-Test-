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
    @IBOutlet weak var skuLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
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
        skuLabel.applySkin(LabelSkin.title)
        amountLabel.applySkin(LabelSkin.body)
        totalLabel.applySkin(LabelSkin.body)
    }
    
    // MARK: Binding
    private func bindViewModel() {
        assert(viewModel != nil)
        let input = TradeDetailsViewModel.Input(trigger: self.rx.viewWillAppear)
        let output = viewModel.transform(input: input)
        
        output.sku.bind(to: skuLabel.rx.text).disposed(by: disposeBag)
        output.amount.bind(to: amountLabel.rx.text).disposed(by: disposeBag)
        output.totalTradeEuro.bind(to: totalLabel.rx.text).disposed(by: disposeBag)
        
    }

}
