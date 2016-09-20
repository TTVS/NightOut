//
//  SignInViewController.swift
//  Clubber
//
//  Created by Terra on 6/1/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit
import CoreData
import LocalAuthentication
import Security

class SignInViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {
    
    var colorX : UIColor = UIColor(red: (10/255.0), green: (237/255.0), blue: (213/255.0), alpha: 1.0) //custom Cyan Color
    var fbColor : UIColor = UIColor(red: (61/255.0), green: (84/255.0), blue: (152/255.0), alpha: 1.0) //custom Cyan Color

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var signInImageView: UIImageView!
    @IBOutlet var facebookLoginButton: FBSDKLoginButton!
    
    
    
    // UIAlertView Alert
    func displayAlertMessage(alertTitle:String, alertDescription:String) -> Void {
        // hide activityIndicator view and display alert message
        //        self.activityIndicatorView.hidden = true
        let errorAlert = UIAlertView(title:alertTitle, message:alertDescription, delegate:nil, cancelButtonTitle:"OK")
        errorAlert.show()
    }
    
    
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        // validate presense of required parameters
        
        if self.emailTextField.text!.isValidEmail(self.emailTextField.text!) == false {
            self.displayAlertMessage("Invalid Email Address", alertDescription:
                "Please input valid email address. Email is Case Sensitive.")
        } else if self.passwordTextField.text!.characters.count < 8 {
                self.displayAlertMessage("Invalid Password", alertDescription:
                    "Passwords must contain 8 values or more.")
        } else {
            makeSignInRequest()
        }
        
    }
    
    func makeSignInRequest() {
        let manager = AFHTTPRequestOperationManager()
        let url = "https://nightout.herokuapp.com/api/v1/sessions?"
        let loginParams = [
            "session[email]" : "\(emailTextField.text!)",
            "session[password]" : "\(passwordTextField.text!)"
        ]
        print("\(emailTextField.text)")
        print("\(passwordTextField.text)")
        
        manager.responseSerializer = AFJSONResponseSerializer()

        manager.POST(url,
            parameters: loginParams,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
                print("JSON: " + responseObject.description)

                // update userLoggedInFlag
                self.updateUserLoggedInFlag()
                
                // save API AuthToken and ExpiryDate in Keychain
//                let data = NSData!()
//                let responseDict = (try! NSJSONSerialization.JSONObjectWithData(data,
//                    options: NSJSONReadingOptions.AllowFragments)) as! NSDictionary
                
                self.saveApiTokenInKeychain(responseObject)
                
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                print("We got an error here.. \(error.localizedDescription)")
                
                let errorMenu = UIAlertController(title: nil, message: "Error Connecting. Please Confirm Email & Password Are Correct.", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: {
                    (alert: UIAlertAction) -> Void in
                    print("Cancelled")
                })
                errorMenu.addAction(okAction)
                
                self.presentViewController(errorMenu, animated: true, completion: nil)
        })
    }
    
    // Update the NSUserDefaults flag
    func updateUserLoggedInFlag() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("loggedIn", forKey: "userLoggedIn")
        defaults.synchronize()
    }
    
    func saveApiTokenInKeychain(tokenDict:AnyObject) {
        let MyKeychainWrapper = KeychainWrapper()
        MyKeychainWrapper.mySetObject(self.passwordTextField.text, forKey:kSecValueData)
        MyKeychainWrapper.writeToKeychain()
        
        let paperNavController: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("RootPaperNavigationVC")
        self.presentViewController(paperNavController, animated: true, completion: nil)

    }
    

    
    
    // Go Back To Previous VC
    @IBAction func back(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            NSLog("back")
        }
    }
    
    
    // Go To Another InstagramLogin.storyboard
    @IBAction func instagramLoginPressed(sender: UIButton) {
        let storyboard = UIStoryboard(name: "InstagramLogin", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("InitialInstagramController") 
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Text Delegates
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        
        //FBSDK
        self.facebookLoginButton.delegate = self
        facebookLoginButton.setBackgroundImage(UIImage(named: "fbInfill"), forState: UIControlState.Normal)
        facebookLoginButton.setImage(UIImage(named: "fbLogoWhite"), forState: UIControlState.Normal)
        facebookLoginButton.setTitle("FB Login", forState: UIControlState.Normal)
        facebookLoginButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        view.addSubview(facebookLoginButton)
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
        // User is already logged in, do work such as go to next view controller.
        } else {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Text Field Return Resign First Responder
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - Add TextFieldInput Navigation Arrows above Keyboard
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        let keyboardToolBar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, 320, 50))
        let keyboardBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "upButton"), style: UIBarButtonItemStyle.Plain, target: self, action: "previousTextField"),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(image: UIImage(named: "downButton"), style: UIBarButtonItemStyle.Plain, target: self, action: "nextTextField")
        ]
    
        keyboardToolBar.setItems(keyboardBarButtonItems, animated: false)
        keyboardToolBar.tintColor = colorX
        keyboardToolBar.barStyle = UIBarStyle.Black
        keyboardToolBar.sizeToFit()
        textField.inputAccessoryView = keyboardToolBar
        return true
    }
    
    func nextTextField() {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
    }
    
    func previousTextField() {
            passwordTextField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
    }

    
    
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    //MARK: - Facebook Delegate Methods
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil) {
            // Process error
        } else if result.isCancelled {
            // Handle cancellations
        } else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                print("User Email is: \(userEmail)")
            }
        })
    }
  
}



















