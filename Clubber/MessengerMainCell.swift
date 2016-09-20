//
//  MessengerMainCell.swift
//  Clubber
//
//  Created by Terra on 9/2/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class MessengerMainCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var friendImage: UIImageView!
    @IBOutlet var friendButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
