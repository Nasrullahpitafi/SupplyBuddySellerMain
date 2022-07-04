//
//  ProductDetailTableViewCell.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 27/01/2022.
//  Copyright © 2022 Asjd. All rights reserved.
//

import UIKit

class ProductDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
