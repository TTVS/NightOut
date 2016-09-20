//
//  IntroductoryContentViewController.swift
//  Clubber
//
//  Created by Terra on 6/1/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class IntroductoryContentViewController: UIViewController {
    
    @IBOutlet var introductoryImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func buttonAction(sender: UIButton) {
        
    }
    
    
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.introductoryImageView.image = UIImage(named: self.imageFile)
        self.titleLabel.text = self.titleText
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
