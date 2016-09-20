//
//  TableSelectionTableVC.swift
//  Clubber
//
//  Created by Terra on 9/25/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class TableSelectionTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var selectedItems: [String: Bool] = [:]

    
    // Table Selection Array (Indoor Only)
    var indoorPax = ["2 Pax","4 Pax","6 Pax"]
    var indoorPrice = ["RM20.00", "RM20.00", "RM20.00"]
    var indoorTableAvailability = ["4 Tables Available","8 Tables Available","2 Tables Available"]

    var colorX : UIColor = UIColor(red: (90/255.0), green: (225/255.0), blue: (200/255.0), alpha: 1.0) //custom Cyan Color
    var colorY : UIColor = UIColor(red: (230/255.0), green: (48/255.0), blue: (66/255.0), alpha: 1.0) //custom Coral Red Color
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    // menu function
    private var menuTransitionManager = MenuTransitionManager()

    @IBAction func back(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)

            NSLog("back")
        }
    }
    
    // swipe to go back
    let swipeBack = UISwipeGestureRecognizer()

    @IBAction func goToPaymentConfirmationButtonPressed(sender: UIButton) {
        let paymentConfirmationVC: UINavigationController = self.storyboard!.instantiateViewControllerWithIdentifier("paymentConfirmationNavVC") as! UINavigationController
        
//        updateMessageAndDismiss()
        self.presentViewController(paymentConfirmationVC, animated: true, completion: nil)
        
        
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        self.setNeedsStatusBarAppearanceUpdate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
        
        // menu transitioning delegate
        self.title = "Table Selection"

        // swipe to go back
        swipeBack.direction = UISwipeGestureRecognizerDirection.Right
        swipeBack.addTarget(self, action: "swipeBack:")
        self.view.addGestureRecognizer(swipeBack)
    
        //Table View
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.automaticallyAdjustsScrollViewInsets = false
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clearColor()
        self.tableView.backgroundView = backgroundView

        //add image to table view
        var backgroundImageView: UIImageView
        backgroundImageView = UIImageView(frame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        backgroundImageView.image = UIImage(named: "demo")
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
//        self.tableView.backgroundView = backgroundImageView
        
        
        
        self.tableView.reloadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Swipe to go Back Gesture
    func swipeBack(sender: UISwipeGestureRecognizer) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            NSLog("back")
        }
    }
    

    //MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return 1
            
        case 1:
            return 1
            
        case 2:
            return 1
            
        case 3:
            return 3
            
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("tableSelectionCell") as! TableSelectionCell

        
        // table view cell selected color
        let selectedCellColor = UIView()
        selectedCellColor.backgroundColor = UIColor.lightTextColor()
        selectedCellColor.alpha = 0.5
        cell.selectedBackgroundView = selectedCellColor

        // Configure the cell
        switch (indexPath.section) {
        case 0:
            cell.paxLabel.text = "7 Pax"
            cell.tablePriceLabel.text = "RM40.00"
            cell.tableAvailabilityLabel.text = "Available"
    
        case 1:
            cell.paxLabel.text = "9 Pax"
            cell.tablePriceLabel.text = "RM25.00"
            cell.tableAvailabilityLabel.text = "Available"
            
        case 2:
            cell.paxLabel.text = "4 Pax"
            cell.tablePriceLabel.text = "RM20.00"
            cell.tableAvailabilityLabel.text = "5 Tables Available"
            
        case 3:
            cell.paxLabel.text = indoorPax[indexPath.row]
            cell.tablePriceLabel.text = indoorPrice[indexPath.row]
            cell.tableAvailabilityLabel.text = indoorTableAvailability[indexPath.row]
            
        default:
            cell.paxLabel.text = ""
            cell.tablePriceLabel.text = ""
            cell.tableAvailabilityLabel.text = ""
        }
        
        return cell
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = self.tableView.dequeueReusableCellWithIdentifier("tableSelectionCell") as! TableSelectionCell
//
//        let selectedItem = cell.tableAvailabilityLabel.objectAtIndex(indexPath.row) as String
//        let itemId = selectedItem.componentsSeparatedByString("$%^")
//        // add to self.selectedItems
//        selectedItems[itemId[1]] = true
//    }
    
//    func updateMessageAndDismiss() {
//        let cell = self.tableView.dequeueReusableCellWithIdentifier("tableSelectionCell") as! TableSelectionCell
//
//        SharingManager.sharedInstance.eventName = cell.tableAvailabilityLabel.text!
//    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("headerCell") as! TableSelectionCell
        
        
        switch (section) {
        case 0:
            headerCell.headerLabel.text = "VIP Lounge"
        case 1:
            headerCell.headerLabel.text = "Cigar Room"
        case 2:
            headerCell.headerLabel.text = "Outdoor"
        case 3:
            headerCell.headerLabel.text = "Indoor"
        default:
            headerCell.headerLabel.text = "Other"
        }
        
        return headerCell
    }
    

//    
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
//        footerView.backgroundColor = UIColor.clearColor()
//        
//        return footerView
//    }
//    
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 40.0
//    }
}
