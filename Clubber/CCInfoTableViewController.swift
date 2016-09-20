//
//  CCInfoTableViewController.swift
//  Clubber
//
//  Created by Terra on 8/26/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class CCInfoTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet var creditCardNumber: UITextField!
    @IBOutlet var creditCardExpirationDate: UITextField!
    @IBOutlet var creditCardCardholder: UITextField!
    
    @IBOutlet var billingAddress: UITextField!
    @IBOutlet var contactNumber: UITextField!
    
    @IBAction func datePickerTapped(sender: AnyObject) {
        DatePopPickerView().show("Expiration Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .Date) {
            (date) -> Void in
            self.creditCardExpirationDate.text = DatePopPickerView().dateFormatter.stringFromDate(date)
        }
        self.creditCardNumber.resignFirstResponder()
        self.creditCardCardholder.resignFirstResponder()
        self.billingAddress.resignFirstResponder()
        self.contactNumber.resignFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //text field properties
        self.creditCardCardholder.delegate = self
//        self.creditCardExpirationDate.delegate = self
        self.creditCardNumber.delegate = self
        
        self.billingAddress.delegate = self
        self.contactNumber.delegate = self

        
        //add credit card image to table view
        let viewHeight = CGRectGetHeight(self.tableView.frame)
        let viewWidth = CGRectGetWidth(self.tableView.frame)
        
        let backgroundImageView: UIImageView
        backgroundImageView = UIImageView(frame:CGRectMake(3, 108, viewWidth - 6, 200))
        backgroundImageView.image = UIImage(named: "creditCardLayout")
        backgroundImageView.contentMode = UIViewContentMode.ScaleToFill
        
        let backgroundViewHolder = UIView()
//        let lightBeigeColor : UIColor = UIColor(red: (231/255.0), green: (231/255.0), blue: (231/255.0), alpha: 1.0)
//        let lightDarkColor : UIColor = UIColor(red: (20/255.0), green: (20/255.0), blue: (21/255.0), alpha: 1.0)
//        backgroundViewHolder.backgroundColor = lightDarkColor
        
        backgroundViewHolder.frame = CGRectMake(0, 0, viewWidth, viewHeight)
        backgroundViewHolder.addSubview(backgroundImageView)
        
        self.tableView.backgroundView = backgroundViewHolder
        self.tableView.backgroundColor = UIColor.whiteColor()
        
        
        //remove excess rows from table view
        tableView.tableFooterView = UIView(frame:CGRectZero)

            
        //dismiss keyboard when single or multiple tap(s)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //dismiss keyboard when single or multiple tap(s)
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    

    
    
    
    //dismiss keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.creditCardCardholder.resignFirstResponder()
//        self.creditCardExpirationDate.resignFirstResponder()
        self.creditCardNumber.resignFirstResponder()
        
        self.billingAddress.resignFirstResponder()
        self.contactNumber.resignFirstResponder()
        return true
    }
        


}
