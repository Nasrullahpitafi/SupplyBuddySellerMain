//
//  InvoiceListTableViewCell.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 22/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit

class InvoiceListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var budgetLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
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
