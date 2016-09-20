//
//  ActivityTableViewController.swift
//  Clubber
//
//  Created by Terra on 9/14/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class ActivityTableViewController: UITableViewController, MenuTransitionManagerDelegate {
    
    // menu function
    private var menuTransitionManager = MenuTransitionManager()

    var activities = [ActivityModel]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
        
        // menu transitioning delegate
        self.title = "Activity"

        //Table View
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        
        // activities array
        self.activities = [
            ActivityModel(usersImage: "avatar1", comments: "Caitlyn sent you a friend request!", commentsImage: "addFriendButton"),
            ActivityModel(usersImage: "avatar2", comments: "Shirlyn invited you to a party: 8pm this Friday at Ikki", commentsImage: "image1"),
            ActivityModel(usersImage: "avatar3", comments: "Your Facebook friend Jane L. is on Clubber", commentsImage: "addFriendButton"),
            ActivityModel(usersImage: "avatar4", comments: "Natalie invited you to a party: 11pm this Saturday at Zouk", commentsImage: "image3"),
            ActivityModel(usersImage: "avatar5", comments: "Kelsie K. sent you a friend request!", commentsImage: "addFriendButton"),
            ActivityModel(usersImage: "avatar6", comments: "Matthew invited you to a party: 11pm this Sunday at Ikki", commentsImage: "image"),
            ActivityModel(usersImage: "avatar7", comments: "Your Instagram friend Justin is on Clubber", commentsImage: "addFriendButton"),
            ActivityModel(usersImage: "avatar8", comments: "Marilyn invited you to a party: 11pm this Saturday at Zouk", commentsImage: "image2"),
            ActivityModel(usersImage: "avatar9", comments: "Karen invited you to a party: 11pm this Saturday at Zouk", commentsImage: "image3"),
            ActivityModel(usersImage: "mainAvatar1", comments: "Mellisa Q. invited you to a party: 11pm this Saturday at Zouk", commentsImage: "image4"),
            ActivityModel(usersImage: "mainAvatar2", comments: "Victoria invited you to a party: 11pm this Saturday at Zouk", commentsImage: "image"),
            ActivityModel(usersImage: "mainAvatar3", comments: "Aeve invited you to a party: 11pm this Saturday at Zouk", commentsImage: "image1"),
            ActivityModel(usersImage: "mainAvatar4", comments: "Your Instagram friend Joseph is on Clubber", commentsImage: "addFriendButton")
        ]
        
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.activities.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ActivityCell = self.tableView.dequeueReusableCellWithIdentifier("activityCell", forIndexPath: indexPath) as! ActivityCell
        
        var activity : ActivityModel
        
        activity = activities[indexPath.row]
        
        
        cell.userImageView.image = activity.userImage
        cell.commentLabel.text = activity.comment
        cell.commentImageView.image = activity.commentImage
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    
    //MARK: - SlideDownMenuProperties
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if let menuTableViewController = segue.destinationViewController as? SideMenuTableViewController {
                menuTableViewController.currentItem = self.title!
                
                // Assign animator
                self.menuTransitionManager.delegate = self
                menuTableViewController.transitioningDelegate = self.menuTransitionManager
            }
    }
    
    func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
