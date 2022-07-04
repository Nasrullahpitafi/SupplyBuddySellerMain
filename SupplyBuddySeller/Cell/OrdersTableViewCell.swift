//
//  OrdersTableViewCell.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 21/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var orderimage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var detailBtn: UIButton!
    
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
        orderimage.layer.borderWidth = 0.2
        orderimage.layer.masksToBounds = false
        orderimage.layer.borderColor = UIColor.black.cgColor
        orderimage.layer.cornerRadius = orderimage.frame.height/2
        orderimage.clipsToBounds = true
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
