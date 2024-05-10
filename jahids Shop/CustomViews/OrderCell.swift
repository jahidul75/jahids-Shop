//
//  OrderCell.swift
//  jahids Shop
//
//  Created by jahidul islam on 2/5/24.
//

import UIKit
import SwiftyJSON

class OrderCell: UICollectionViewCell {
    
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var orderProductName: UILabel!
    @IBOutlet weak var orderProductDescripsion: UILabel!
    @IBOutlet weak var orderProductPrice: UILabel!
    @IBOutlet weak var orderCoantity: UILabel!
    @IBOutlet weak var orderStepper: UIStepper!
    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var orderSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.orderView.ApplyCorner(CornerRadius: 10.0, BorderWidth: 1.0, BorderColor: .systemRed)
    }
    
    func setOrderInformation (product: DisplayProduct) {
        self.orderImage.image = UIImage(systemName: "soccerball")
        self.orderProductName.text = product.name
        self.orderProductDescripsion.text = product.description
        
        let strokeEffect: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.strikethroughColor: UIColor.red,
        ]
        
        let originalPrice = NSAttributedString(string: "TK " + String(product.originalPrice), attributes: strokeEffect)
        let finalAttributedString = NSMutableAttributedString()
        finalAttributedString.append(originalPrice)
        finalAttributedString.append(NSAttributedString(string: " TK "))
        finalAttributedString.append(NSAttributedString(string: String(product.discountedPrice)))
        
        self.orderProductPrice.attributedText = finalAttributedString
    }
}
