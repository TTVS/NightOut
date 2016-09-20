//
//  SideMenuTableViewController.swift
//  Clubber
//
//  Created by Terra on 6/3/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit


class SideMenuTableViewController: UITableViewController {
    
    var menuItems = ["Feed", "Activity", "Create", "Messenger", "My ID"]
    var currentItem = "Feed"

    
    // Go To Main.storyboard
    @IBAction func backToHomePagePressed(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("WelcomeViewController") 
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    
    // Feed Cell Pressed
    @IBAction func feedCellPressed(sender: UIButton) {
//        let viewController = GRootViewController(nibName: nil, bundle: nil)
////        viewController.asyncFlag = true // this is async view
//        viewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
//        self.presentViewController(viewController, animated: true, completion: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("RootPaperNavigationVC") as! UINavigationController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    // Logout Cell Pressed
    @IBAction func logoutCellPressed(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier("signInVC") 
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layoutMargins = UIEdgeInsetsZero
        
//        var backgroundImageView: UIImageView
//        backgroundImageView = UIImageView(frame:CGRectMake(0, 0, 600, 600))
//        backgroundImageView.image = UIImage(named: "cityBase")
//        self.tableView.backgroundView = backgroundImageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    

//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        var selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
//        selectedCell.contentView.backgroundColor = UIColor.blueColor()
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//    }

    
    


    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 1
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete method implementation.
//        // Return the number of rows in the section.
//        return menuItems.count
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("slideMenuCell", forIndexPath: indexPath) as! MenuTableViewCell
//        
//        // Configure the cell...
//        cell.titleLabel.text = menuItems[indexPath.row]
//        cell.titleLabel.textColor = (menuItems[indexPath.row] == currentItem) ? UIColor.whiteColor() : UIColor.grayColor()
//        
//        return cell
//    }
//    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//    }
    
    
    

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let menuTableViewController = segue.sourceViewController as! SideMenuTableViewController
        if let selectedRow = menuTableViewController.tableView.indexPathForSelectedRow?.row {
            currentItem = menuItems[selectedRow]
        }
    }
    
    func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
































