//
//  ProductManagementTableViewCell.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 22/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit

class ProductManagementTableViewCell: UITableViewCell {

    
    @IBOutlet weak var itemimage: UIImageView!
    
    @IBOutlet weak var itemnameLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var switchBtn: UISwitch!
    
    @IBOutlet weak var productdetaulBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 3
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }

}
