//
//  CircularImagePickerVC.swift
//  Clubber
//
//  Created by Terra on 14/10/2015.
//  Copyright © 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class CircularImagePickerVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.opaque = false
        self.view.backgroundColor = UIColor.clearColor()
        
        let imageOverlay: UIImage = UIImage(named:"crosshair")!
        let imageOverlayView: UIImageView = UIImageView(image: imageOverlay)
        imageOverlayView.frame = self.view.frame
//        imageOverlayView.contentMode = UIViewContentMode.Center
        self.view.addSubview(imageOverlayView)
        
        
        
        
        let selfieButton = UIButton(type: UIButtonType.RoundedRect)
        selfieButton.setTitle("Snap a Picture", forState: UIControlState.Normal)
        selfieButton.frame = CGRectMake(0, 0, 320, 40)
        
        selfieButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), selfieButton.center.y)

        
        
    
        let singleFingerTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")

        selfieButton.addGestureRecognizer(singleFingerTap)
        
        self.view.addSubview(selfieButton)

        
    }
    
    // Tap on Event Collection View Cell
    func handleSingleTap(recognizer:UITapGestureRecognizer) {
        let eventDetailViewController: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("EventDetailVC")
        self.presentViewController(eventDetailViewController, animated: true, completion: nil)
        
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
