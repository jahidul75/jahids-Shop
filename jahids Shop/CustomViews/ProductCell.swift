//
//  ProductCell.swift
//  jahids Shop
//
//  Created by jahidul islam on 14/3/24.
//

import UIKit
import SwiftyJSON
import SwiftUI

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLavel: UILabel!
    @IBOutlet weak var ProductDescriptionLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var ProductOrderButton: UIButton!
    @IBOutlet weak var ProductCartButton: UIButton!
    @IBOutlet weak var ProductView: UIView!
    
    var productsFromAPI: [JSON] = [
        
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.ProductView.ApplyCorner(CornerRadius: 5.0, BorderWidth: 1.0, BorderColor: .systemRed)
        self.ProductCartButton.ApplyCorner(CornerRadius: 7.0, BorderWidth: 0.0, BorderColor: .clear)
        
    }
    
    func setProductInformation (product: DisplayProduct) {
        self.productImageView.image = UIImage(systemName: "soccerball")
        self.productNameLavel.text = product.name
        self.ProductDescriptionLabel.text = product.description
        
        let strokeEffect: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.strikethroughColor: UIColor.red,
        ]
        
        let originalPrice = NSAttributedString(string: "TK " + String(product.originalPrice), attributes: strokeEffect)
        let finalAttributedString = NSMutableAttributedString()
        finalAttributedString.append(originalPrice)
        finalAttributedString.append(NSAttributedString(string: " TK "))
        finalAttributedString.append(NSAttributedString(string: String(product.discountedPrice)))
        
        self.productPriceLabel.attributedText = finalAttributedString
    }

}
