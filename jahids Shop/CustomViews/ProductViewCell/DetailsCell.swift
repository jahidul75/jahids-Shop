//
//  DetailsCell.swift
//  jahids Shop
//
//  Created by jahidul islam on 23/5/24.
//

import UIKit

class DetailsCell: UICollectionViewCell {

    @IBOutlet weak var nameLavel: UILabel!
    @IBOutlet weak var descriptionLavel: UILabel!
    @IBOutlet weak var priceLavel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.orderButton.ApplyCorner(CornerRadius: 7.0, BorderWidth: 0.0, BorderColor: .clear)
        self.cartButton.ApplyCorner(CornerRadius: 7.0, BorderWidth: 0.0, BorderColor: .clear)
    }

}
