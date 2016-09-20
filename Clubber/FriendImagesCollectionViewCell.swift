//
//  FriendImagesCollectionViewCell.swift
//  Clubber
//
//  Created by Terra on 6/10/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class FriendImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageLabel: UILabel!
    @IBOutlet var pictureImageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    var imageView: UIImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 16, width: frame.size.width, height: frame.size.height))
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        contentView.addSubview(imageView)
    }
}

