//
//  ProfileViewController.swift
//  Clubber
//
//  Created by Terra on 5/27/15.
//  Copyright (c) 2015 Terranz. All rights reserved.
//

import UIKit
import QuartzCore
import SwiftyJSON

class ProfileViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, RSKImageCropViewControllerDelegate {
    
    // UIAlertView Alert
    func displayAlertMessage(alertTitle:String, alertDescription:String) -> Void {
        let errorAlert = UIAlertView(title:alertTitle, message:alertDescription, delegate:nil, cancelButtonTitle:"OK")
        errorAlert.show()
    }
    
    // swipe to go back
    let swipeBack = UISwipeGestureRecognizer()
    var colorX : UIColor = UIColor(red: (90/255.0), green: (225/255.0), blue: (200/255.0), alpha: 1.0) //custom Cyan Color

    @IBOutlet var menuButton: UIBarButtonItem!
    


    
    @IBOutlet var profileView: UITableView!
    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var aboutTextView: UITextView!
    
    @IBOutlet var contactNumberTextField: UITextField!
    @IBOutlet var twitterTextField: UITextField!
    @IBOutlet var facebookTextField: UITextField!
    
    @IBAction func back(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            NSLog("back")
        }
    }
    
    

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.firstNameTextField.resignFirstResponder()
        self.lastNameTextField.resignFirstResponder()
        self.locationTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.aboutTextView.resignFirstResponder()
        self.contactNumberTextField.resignFirstResponder()
        self.twitterTextField.resignFirstResponder()
        self.facebookTextField.resignFirstResponder()
        
        return true
    }
    

    
    
    
    
    
    
    // Image Picker With Crop Circle
    
    let imagePicker = UIImagePickerController()
    var imageCropVC : RSKImageCropViewController!
    
    @IBAction func chooseProfilePicture(sender: AnyObject) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        
        let photoAlbumAction = UIAlertAction(title: "Photo Album", style: .Default, handler: {
            (alert: UIAlertAction) -> Void in
            
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
            
            print("Photo Album Opened")
            
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
            self.setNeedsStatusBarAppearanceUpdate()

        })
        
        
        
        let cameraAction = UIAlertAction(title: "Camera", style: .Default, handler: {
            (alert: UIAlertAction) -> Void in
            
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
        
            print("Launch Camera")
            
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
            self.setNeedsStatusBarAppearanceUpdate()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction) -> Void in
            print("Cancelled")
            
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
            self.setNeedsStatusBarAppearanceUpdate()
        })
        
        
        optionMenu.addAction(photoAlbumAction)
        optionMenu.addAction(cameraAction)
        optionMenu.addAction(cancelAction)
        
        optionMenu.view.tintColor = colorX
        optionMenu.view.backgroundColor = UIColor.darkGrayColor()
        self.imagePicker.view.backgroundColor = UIColor.blackColor()

        
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        self.setNeedsStatusBarAppearanceUpdate()
        
    }
    
    
    
    func imageCropViewControllerDidCancelCrop(controller: RSKImageCropViewController!) {
        
        self.navigationController?.popViewControllerAnimated(true)
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func imageCropViewController(controller: RSKImageCropViewController!, didCropImage croppedImage: UIImage!, usingCropRect cropRect: CGRect) {
        
        self.profileImageView.image = croppedImage
        
        self.navigationController?.popViewControllerAnimated(true)
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        
        let image : UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        picker.dismissViewControllerAnimated(false, completion: { () -> Void in
            
            self.imageCropVC = RSKImageCropViewController(image: image, cropMode: RSKImageCropMode.Circle)
            self.imageCropVC.delegate = self
            self.imageCropVC.view.backgroundColor = UIColor.lightGrayColor()
            
            self.navigationController?.pushViewController(self.imageCropVC, animated: true)
            
            UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
            UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
            self.setNeedsStatusBarAppearanceUpdate()
            
        })
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    
    
    



    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
        // swipe to go back
        swipeBack.direction = UISwipeGestureRecognizerDirection.Right
        swipeBack.addTarget(self, action: "swipeBack:")
        self.view.addGestureRecognizer(swipeBack)
        
        
        
        //SideMenuProperties
//        if self.revealViewController() != nil {
//            menuButton.target = self.revealViewController()
//            menuButton.action = "revealToggle:"
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        }
//        self.revealViewController().rearViewRevealWidth = 250
        
        
        imagePicker.delegate = self
        
        //add image to table view
        var backgroundImageView: UIImageView
        backgroundImageView = UIImageView(frame:CGRectMake(0, 0, 600, 600))
        backgroundImageView.image = UIImage(named: "Base2updated")
        self.tableView.backgroundView = backgroundImageView
        
        
        //image picker properties
        self.profileImageView.layer.masksToBounds = true
        self.profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        self.profileImageView.clipsToBounds = true
        
        //text field properties
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.locationTextField.delegate = self
        self.passwordTextField.delegate = self
        self.emailTextField.delegate = self
        self.contactNumberTextField.delegate = self
        self.twitterTextField.delegate = self
        self.facebookTextField.delegate = self
        
        //text view properties
        aboutTextView.delegate = self
        
        //remove excess rows from table view
        tableView.tableFooterView = UIView(frame:CGRectZero)


    }

        
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        self.setNeedsStatusBarAppearanceUpdate()
        
        tableView.reloadData()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        // GET Users
        let manager = AFHTTPRequestOperationManager()
        manager.GET("https://nightout.herokuapp.com/api/v1/users?",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                print("JSON: " + responseObject.description)
                let json = JSON(responseObject)
                
                
                let email = json["users"][0]["email"].string
                print("SwiftyJSON: \(email)")
                self.emailTextField.text! = email!
                
                let password = json["users"][0]["password"].string
                print("SwiftyJSON: \(password)")
//                self.passwordTextField.text! = password!
                
                let firstName = json["users"][0]["first_name"].string
                print("SwiftyJSON: \(firstName)")
                self.firstNameTextField.text! = firstName!
                
                let lastName = json["users"][0]["last_name"].string
                print("SwiftyJSON: \(lastName)")
                self.lastNameTextField.text! = lastName!
                
                let profileImage = json["users"][0]["image"].string
                print("SwiftyJSON: \(profileImage)")
//                self.profileImageView.image = UIImage(named: profileImage)
                
                let profileDescription = json["users"][0]["description"].string
                print("SwiftyJSON: \(profileDescription)")
//                self.aboutTextView.text! = profileDescription!
                
                let location = json["users"][0]["location"].string
                print("SwiftyJSON: \(location)")
//                self.locationTextField.text! = location!
                
                let contactNumber = json["users"][0]["contact_number"].string
                print("SwiftyJSON: \(contactNumber)")
//                self.contactNumberTextField.text! = contactNumber!
                
                
                
                if let userArray = json["users"].array {
                    var users = [UserModel]()
                    
                    for userDict in userArray {
                        let userEmail: String? = userDict["email"].string
                        let userPassword: String? = userDict["password"].string
                        let userFirstName: String? = userDict["first_name"].string
                        let userLastName: String? = userDict["last_name"].string
                        let userProfileImage: String? = userDict["image"].string
                        let userDescription: String? = userDict["description"].string
                        let userLocation: String? = userDict["location"].string
                        let userContactNumber: String? = userDict["contact_number"].string
                        
                        let user = UserModel(userEmail: userEmail, userPassword: userPassword, userPasswordConfirmation: nil, userFirstName: userFirstName, userLastName: userLastName, userType: nil, userImage: userProfileImage, userDescription: userDescription, userLocation: userLocation, userContactNumber: userContactNumber)
                        
                        users.append(user)
                    }
                    print(users)
                }
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                print("Error: " + error.localizedDescription)
                self.displayAlertMessage("Server Error", alertDescription: "Failed to get from server.")
        })
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        self.setNeedsStatusBarAppearanceUpdate()
    }

    
    
    
    
    
    //MARK: Swipe to go Back Gesture
    func swipeBack(sender: UISwipeGestureRecognizer) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            NSLog("back")
        }
    }
    
    
    
    
    // MARK: - UITextViewDelegate
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    
    
    
  }

















