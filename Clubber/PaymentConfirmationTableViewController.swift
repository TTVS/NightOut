//
//  PaymentConfirmationTableViewController.swift
//  Clubber
//
//  Created by Terra on 8/27/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class PaymentConfirmationTableViewController: UITableViewController {
    

    @IBOutlet var eventName: UILabel!
    @IBOutlet var eventLocation: UILabel!
    
    @IBOutlet var eventTime: UILabel!
    @IBOutlet var eventDate: UILabel!
    
    @IBOutlet var ticketType: UILabel!
    @IBOutlet var ticketQuantity: UILabel!
    @IBOutlet var ticketPrice: UILabel!
    
    @IBOutlet var tableSeats: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewHeight = CGRectGetHeight(self.tableView.frame)
        let viewWidth = CGRectGetWidth(self.tableView.frame)
        
        let backgroundImageView: UIImageView
        backgroundImageView = UIImageView(frame:CGRectMake(0, 0, viewWidth, viewHeight))
        backgroundImageView.image = UIImage(named: "demo")
        backgroundImageView.contentMode = UIViewContentMode.Left
        backgroundImageView.alpha = 0.5
        
        //self.tableView.backgroundView = backgroundImageView
        
        
        //remove excess rows from table view
        tableView.tableFooterView = UIView(frame:CGRectZero)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.eventName.text = SharingManager.sharedInstance.eventName
        self.eventLocation.text = SharingManager.sharedInstance.eventVenue
        self.eventTime.text = SharingManager.sharedInstance.eventTime
        self.eventDate.text = SharingManager.sharedInstance.eventDate
        
        self.ticketType.text = SharingManager.sharedInstance.ticketType
        self.ticketQuantity.text = SharingManager.sharedInstance.ticketQuantity
        self.ticketPrice.text = SharingManager.sharedInstance.ticketPrice
        
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
