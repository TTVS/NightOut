//
//  InviteFriendCell.swift
//  Clubber
//
//  Created by Terra on 6/10/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class InviteFriendCell: UITableViewCell {

    //    var isHighLighted:Bool = false
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var friendImage: UIImageView!
    @IBOutlet var inviteButton: UIButton!
    @IBOutlet var friendButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //    func buttonClicked(sender: UIButton){
    //        dispatch_async(dispatch_get_main_queue(), {
    //
    //            if self.isHighLighted == false {
    //                sender.highlighted = true
    //                self.isHighLighted = true
    //            } else {
    //                sender.highlighted = false
    //                self.isHighLighted = false
    //            }
    //        })
    //        
    //    }
    
    
    
}
