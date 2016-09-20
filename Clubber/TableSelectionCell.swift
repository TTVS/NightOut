//
//  TableSelectionCell.swift
//  Clubber
//
//  Created by Terra on 9/25/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class TableSelectionCell: UITableViewCell {
    
    @IBOutlet var paxLabel: UILabel!
    @IBOutlet var tablePriceLabel: UILabel!
    @IBOutlet var tableAvailabilityLabel: UILabel!

    @IBOutlet var headerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
