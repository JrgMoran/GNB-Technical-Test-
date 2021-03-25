//
//  HomeViewController.swift
//  GNB
//
//  Created by Jorge Morán on 11/3/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: ViewController, UITableViewDelegate {
    
    // MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.register(UINib(nibName: TradeCell.identifier, bundle: nil), forCellReuseIdentifier: TradeCell.identifier)
            tableView.rx.setDelegate(self).disposed(by: disposeBag)
        }
    }
    
    // MARK: Injections
    var viewModel: HomeViewModel!
    
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
        let input = HomeViewModel.Input(trigger: self.rx.viewDidAppear)
        let output = viewModel.transform(input: input)
        
        output.trades.bind(to: tableView.rx.items(cellIdentifier: TradeCell.identifier, cellType: TradeCell.self)){ (row,item,cell) in
                    cell.trade = item
        }.disposed(by: disposeBag)
        
        output.isHiddenTableView.bind(to: tableView.rx.isHidden).disposed(by: disposeBag)
    }

}
