//
//  FriendModel.swift
//  Clubber
//
//  Created by Terra on 6/10/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import Foundation
import UIKit

class FriendModel {
    
    var name: String
    var status: String
    var image: UIImage
    
    init(named: String, mood: String, imageName: String) {
        
        self.name = named
        self.status = mood
        
        if let img = UIImage(named: imageName) {
            image = img
        } else {
            image = UIImage(named: "A")!
        }
    }
}