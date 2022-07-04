//
//  MessageTableViewCell.swift
//  SupplyBuddySeller
//
//  Created by Asjd on 28/12/2021.
//  Copyright © 2021 Asjd. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var senderLabel: UILabel!
    
    @IBOutlet weak var senderDateLabel: UILabel!
    
    @IBOutlet weak var receiverLabel: UILabel!
    
    @IBOutlet weak var receiverDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
