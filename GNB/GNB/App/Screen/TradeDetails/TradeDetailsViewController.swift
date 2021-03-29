//
//  TradeDetailsViewController.swift
//  GNB
//
//  Created by Jorge Morán on 25/3/21.
//

import UIKit
import RxSwift
import RxCocoa

class TradeDetailsViewController: ViewController, UITableViewDelegate {
    
    // MARK: IBOutlet
    @IBOutlet weak var skuLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.register(UINib(nibName: TradeConversionCell.identifier, bundle: nil), forCellReuseIdentifier: TradeConversionCell.identifier)
            tableView.rx.setDelegate(self).disposed(by: disposeBag)
        }
    }
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
        output.tradesInAllCurrencies.bind(to: tableView.rx.items(cellIdentifier: TradeConversionCell.identifier, cellType: TradeConversionCell.self)){ (row,item,cell) in
                    cell.textAmount = item
        }.disposed(by: disposeBag)
        
    }

}
