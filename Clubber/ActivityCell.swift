//
//  ActivityCell.swift
//  Clubber
//
//  Created by Terra on 9/14/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {
    

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var imageContentView: UIView!
    @IBOutlet var commentImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
