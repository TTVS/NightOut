//
//  ForgotPWViewController.swift
//  Clubber
//
//  Created by Terra on 6/1/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class ForgotPWViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    // swipe to go back
    let swipeBack = UISwipeGestureRecognizer()


    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var forgotPWImageView: UIImageView!
    @IBAction func sendButtonPressed(sender: UIButton) {
        
        let paperNavController = self.storyboard!.instantiateViewControllerWithIdentifier("RootPaperNavigationVC")
        self.presentViewController(paperNavController, animated: true, completion: nil)
        
    }
    
    @IBAction func back(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            NSLog("back")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // swipe to go back
        swipeBack.direction = UISwipeGestureRecognizerDirection.Right
        swipeBack.addTarget(self, action: "swipeBack:")
        self.view.addGestureRecognizer(swipeBack)
        
        
        self.emailTextField.delegate = self
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //MARK: Swipe to go Back Gesture
    func swipeBack(sender: UISwipeGestureRecognizer) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            NSLog("back")
        }
    }
    
}
