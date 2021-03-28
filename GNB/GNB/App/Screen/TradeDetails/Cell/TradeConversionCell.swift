//
//  TradeConversionCell.swift
//  GNB
//
//  Created by Jorge Morán on 28/3/21.
//  Copyright © 2021 Jorge Morán. All rights reserved.
//

import UIKit

class TradeConversionCell: UITableViewCell {
    static let identifier = "TradeConversionCell"
    
    @IBOutlet private weak var arrowImageView: UIImageView!
    @IBOutlet private weak var amount: UILabel!
    
    var textAmount: String? {
        didSet {
            arrowImageView.image = R.images.arrow
            amount.text(textAmount, withSkin: .body)
        }
    }
    
    override func prepareForReuse() {
        amount.text = nil
        super.prepareForReuse()
    }
    
}
