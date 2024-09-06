//
//  SearchCell.swift
//  jahids Shop
//
//  Created by jahidul islam on 13/3/24.
//

import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var nameLavel: UILabel!
    @IBOutlet weak var priceLavel: UILabel!
    @IBOutlet weak var instockLavel: UILabel!
    @IBOutlet weak var productImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
