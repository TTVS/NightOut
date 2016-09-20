//
//  ActivityModel.swift
//  Clubber
//
//  Created by Terra on 9/14/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import Foundation
import UIKit

class ActivityModel {
    
    var userImage: UIImage
    var comment: String
    var commentImage: UIImage
    
    init(usersImage: String, comments: String, commentsImage: String) {
        
        if let img1 = UIImage(named: usersImage) {
            userImage = img1
        } else {
            userImage = UIImage(named: "A")!
        }
    
        self.comment = comments
        
        if let img2 = UIImage(named: commentsImage) {
            commentImage = img2
        } else {
            commentImage = UIImage(named: "A")!
        }
        
    }
}