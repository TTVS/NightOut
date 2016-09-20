//
//  CreateEventHomeVC.swift
//  Clubber
//
//  Created by Terra on 8/18/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class CreateEventHomeVC: UIViewController, MenuTransitionManagerDelegate, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate {
    
    var colorY : UIColor = UIColor(red: (230/255.0), green: (48/255.0), blue: (66/255.0), alpha: 1.0) //custom Coral Red Color
    var colorX : UIColor = UIColor(red: (90/255.0), green: (225/255.0), blue: (200/255.0), alpha: 1.0) //custom Cyan Color

    // UIAlertView Alert
    func displayAlertMessage(alertTitle:String, alertDescription:String) -> Void {
        let errorAlert = UIAlertView(title:alertTitle, message:alertDescription, delegate:nil, cancelButtonTitle:"OK")
        errorAlert.show()
    }
    
    
    @IBOutlet var eventEntryConditionsTextField: HoshiTextField!
    
    @IBOutlet var eventDescriptionTextView: UITextView!
    
    
    @IBOutlet var eventNameTextField: UITextField!
    @IBOutlet var clubTextField: UITextField!
//    @IBAction func clubPickerTapped(sender: AnyObject) {
//        ClubPopPickerView().show("Club", doneButtonTitle: "Choose", cancelButtonTitle: "Cancel")
//        
////        
////
//        self.clubTextField.resignFirstResponder()
//        self.eventNameTextField.resignFirstResponder()
//        self.eventEntryConditionsTextField.resignFirstResponder()
//        self.eventDescriptionTextView.resignFirstResponder()
//    }
    
    
    
    // time picker
    @IBOutlet var timeTextField: UITextField!
    @IBAction func timePickerTapped(sender: AnyObject) {
        DatePopPickerView().show("Time", doneButtonTitle: "Set", cancelButtonTitle: "Cancel", datePickerMode: .Time) {
            (time) -> Void in
            self.timeTextField.text = DatePopPickerView().timeFormatter.stringFromDate(time)
        }
        self.clubTextField.resignFirstResponder()
        self.eventNameTextField.resignFirstResponder()
        self.eventEntryConditionsTextField.resignFirstResponder()
        self.eventDescriptionTextView.resignFirstResponder()
    }
    
    

    // date picker
    @IBOutlet var dateTextField: UITextField!
    @IBAction func datePickerTapped(sender: AnyObject) {
        DatePopPickerView().show("Date", doneButtonTitle: "Set", cancelButtonTitle: "Cancel", datePickerMode: .Date) {
            (date) -> Void in
            self.dateTextField.text = DatePopPickerView().dateFormatter.stringFromDate(date)
        }
        self.clubTextField.resignFirstResponder()
        self.eventNameTextField.resignFirstResponder()
        self.eventEntryConditionsTextField.resignFirstResponder()
        self.eventDescriptionTextView.resignFirstResponder()
    }
    

    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var eventImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    @IBAction func loadImageButtonTapped(sender: UIButton) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        let photoAlbumAction = UIAlertAction(title: "Photo Album", style: .Default, handler: {
            (alert: UIAlertAction) -> Void in
            
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .PhotoLibrary
            
            self.presentViewController(self.imagePicker, animated: true, completion: nil)

            
            print("Open Photo Album")
        })
        let cameraAction = UIAlertAction(title: "Camera", style: .Default, handler: {
            (alert: UIAlertAction) -> Void in
            
            self.imagePicker.allowsEditing = false
            self.imagePicker.sourceType = .Camera
            
            self.presentViewController(self.imagePicker, animated: true, completion: nil)

            print("Launch Camera")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction) -> Void in
            print("Cancelled")
        })
        
        
        optionMenu.addAction(photoAlbumAction)
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(cancelAction)
                
        optionMenu.view.tintColor = colorX
        optionMenu.view.backgroundColor = UIColor.darkGrayColor()
        self.imagePicker.view.backgroundColor = UIColor.blackColor()
        
        self.presentViewController(optionMenu, animated: true, completion: nil)

    }

    @IBAction func goToTableSelectionButtonPressed(sender: UIButton) {
        let tableSelectionViewController: UINavigationController = self.storyboard!.instantiateViewControllerWithIdentifier("tableSelectionNavVC") as! UINavigationController
        
        if self.eventNameTextField.text == "" {
            self.displayAlertMessage("Event Name", alertDescription: "Please fill in event name.")

        } else if self.clubTextField.text == "" {
            self.displayAlertMessage("Club", alertDescription: "Please fill in a club.")
            
        } else if self.dateTextField.text == "" {
            self.displayAlertMessage("Date", alertDescription: "Please choose a date.")

        } else if self.timeTextField.text == "" {
            self.displayAlertMessage("Time", alertDescription: "Please choose a time.")
            
        } else if self.eventEntryConditionsTextField.text == "" {
            self.displayAlertMessage("Entry Conditions", alertDescription: "Please state an entry condition.\rEg. Must be above legal drinking age.")

        } else if self.eventDescriptionTextView.text == "" {
            self.displayAlertMessage("Description", alertDescription: "Please fill in event description.")

        } else {
            updateMessageAndDismiss()
            self.presentViewController(tableSelectionViewController, animated: true, completion: nil)
        }
        
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func updateMessageAndDismiss() {
        SharingManager.sharedInstance.eventName = self.eventNameTextField.text!
        SharingManager.sharedInstance.eventVenue = self.clubTextField.text!
        SharingManager.sharedInstance.eventTime = self.timeTextField.text!
        SharingManager.sharedInstance.eventDate = self.dateTextField.text!
        SharingManager.sharedInstance.eventEntryCondition = self.eventEntryConditionsTextField.text!
        SharingManager.sharedInstance.eventDescription = self.eventDescriptionTextView.text!
    }
    
    // menu function
    private var menuTransitionManager = MenuTransitionManager()
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let topOffset = CGPointMake(0, 0)
        self.scrollView.setContentOffset(topOffset, animated: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // menu transitioning delegate
        self.title = ""
        
        
        //image picker
        self.imagePicker.delegate = self
        
        self.eventImage.layer.masksToBounds = true
        self.eventImage.layer.cornerRadius = 7
        self.eventImage.clipsToBounds = true

        
        //keyboard functions
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object: nil)
        
        self.eventNameTextField.delegate = self
        self.clubTextField.delegate = self
        self.dateTextField.delegate = self
        self.timeTextField.delegate = self
        
        self.eventEntryConditionsTextField.delegate = self
        self.eventDescriptionTextView.delegate = self
        
        
        
        // colored placeholder text
//        let placeholderColor : UIColor = UIColor(red: (106/255.0), green: (121/255.0), blue: (137/255.0), alpha: 1.0)
        
//        self.eventNameTextField.attributedPlaceholder = NSAttributedString(string:"EVENT NAME",
//            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        
//        self.clubTextField.attributedPlaceholder = NSAttributedString(string:"IKKI",
//            attributes:[NSForegroundColorAttributeName: UIColor.lightTextColor()])
        
        self.dateTextField.attributedPlaceholder = NSAttributedString(string:"DATE",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        self.timeTextField.attributedPlaceholder = NSAttributedString(string:"TIME",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        

        

        
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
    }
    
    

    //MARK: - SlideDownMenuProperties
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMenuFromCreate" {
            if let menuTableViewController = segue.destinationViewController as? SideMenuTableViewController {
                menuTableViewController.currentItem = self.title!
                
                // Assign animator
                self.menuTransitionManager.delegate = self
                menuTableViewController.transitioningDelegate = self.menuTransitionManager
            }
        }
    }
    
    func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    
    
    
    
    
    //MARK: - Keyboard Functions
    func keyboardWasShown (notification: NSNotification) {
//        let viewHeight = self.view.frame.size.height
//        let info : NSDictionary = notification.userInfo!
//        let keyboardSize: CGSize = info.objectForKey(UIKeyboardFrameBeginUserInfoKey)!.CGRectValue.size
//        let keyboardInset = keyboardSize.height - viewHeight/4
        
//        self.scrollView.setContentOffset(CGPointMake(0, keyboardInset), animated: true)
        
    }
    
    func keyboardWillBeHidden (notification: NSNotification) {
//        self.scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.eventNameTextField.delegate = self
        self.clubTextField.delegate = self
        self.dateTextField.delegate = self
        self.timeTextField.delegate = self
        
        self.eventEntryConditionsTextField.delegate = self
        self.eventDescriptionTextView.delegate = self
        
        
//        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.Fade)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.eventNameTextField.resignFirstResponder()
        self.clubTextField.resignFirstResponder()
        self.dateTextField.resignFirstResponder()
        self.timeTextField.resignFirstResponder()
        
        self.eventEntryConditionsTextField.resignFirstResponder()
        self.eventDescriptionTextView.resignFirstResponder()

        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
        
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
            updateMessageAndDismiss()
    }
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    
    
    // MARK: - UITextViewDelegate (dismiss keyboard when return is pressed)
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    

    
    
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            eventImage.contentMode = UIViewContentMode.ScaleAspectFill
            self.eventImage.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        self.setNeedsStatusBarAppearanceUpdate()

    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        self.setNeedsStatusBarAppearanceUpdate()

    }
    
}


























