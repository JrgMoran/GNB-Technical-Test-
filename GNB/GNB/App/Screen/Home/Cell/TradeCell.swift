//
//  TradeCell.swift
//  GNB
//
//  Created by Jorge Morán on 25/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TradeCell: UITableViewCell {
    static let identifier = "TradeCell"
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var body: UILabel!
    var trade: TradeElement? {
        didSet {
            title.text(trade?.sku, withSkin: LabelSkin.title)
            body.text(trade?.amount, withSkin: LabelSkin.body)
        }
    }
    
    override func prepareForReuse() {
        trade = nil
        super.prepareForReuse()
        
    }
    
}

extension Reactive where Base: TradeCell {
    
    var trade:Binder<TradeElement> {
        return Binder(self.base) { view, trade in
            view.trade = trade
        }
    }
    
}
