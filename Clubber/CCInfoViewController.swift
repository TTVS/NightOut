//
//  CCInfoViewController.swift
//  Clubber
//
//  Created by Terra on 9/7/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class CCInfoViewController: UIViewController {
    
    // swipe to go back
    let swipeBack = UISwipeGestureRecognizer()
    
    @IBAction func back(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            NSLog("back")
        }
    }
    
    @IBOutlet var cancelButton: UIButton!
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            NSLog("back")
        }
    }
    
    @IBOutlet var applyButton: UIButton!
    @IBAction func applyButtonPressed(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            NSLog("back")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        self.applyButton.layer.cornerRadius = 3
        self.cancelButton.layer.cornerRadius = 3

        // swipe to go back
        swipeBack.direction = UISwipeGestureRecognizerDirection.Right
        swipeBack.addTarget(self, action: "swipeBack:")
        self.view.addGestureRecognizer(swipeBack)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Swipe to go Back Gesture
    func swipeBack(sender: UISwipeGestureRecognizer) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            NSLog("back")
        }
    }
    


}
