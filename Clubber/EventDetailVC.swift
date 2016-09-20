//
//  EventDetailVC.swift
//  Clubber
//
//  Created by Terra on 8/18/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit
import SwiftyJSON

class EventDetailVC: UIViewController, UIScrollViewDelegate {

    
    // swipe to go back
    let swipeBack = UISwipeGestureRecognizer()

    
    
    
    @IBOutlet var eventName: UILabel!
    @IBOutlet var eventLocation: UILabel!
    
    @IBOutlet var eventTime: UILabel!
    @IBOutlet var eventDate: UILabel!
    
    @IBOutlet var eventDescription: UITextView!
    @IBOutlet var eventEntryConditions: UITextView!
    
    @IBOutlet var ticketType: UILabel!
    @IBOutlet var ticketPrice: UILabel!
    
    
    
    @IBOutlet var scrollView: UIScrollView!
    @IBAction func back(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            NSLog("back")
        }
    }
    
    
    @IBAction func inviteFriendsButtonPressed(sender: AnyObject) {
        let inviteFriendsVC: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("inviteFriendsNavVC")
        self.presentViewController(inviteFriendsVC, animated: true, completion: nil)

    }
    

    // UIAlertView Alert
    func displayAlertMessage(alertTitle:String, alertDescription:String) -> Void {
        let errorAlert = UIAlertView(title:alertTitle, message:alertDescription, delegate:nil, cancelButtonTitle:"OK")
        errorAlert.show()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // swipe to go back
        self.swipeBack.direction = UISwipeGestureRecognizerDirection.Right
        self.swipeBack.addTarget(self, action: "swipeBack:")
        self.view.addGestureRecognizer(swipeBack)
        
        // make text view start from top of scroll view
        self.eventDescription.scrollRangeToVisible(NSMakeRange(0, 0))
//        self.eventEntryConditions.scrollRangeToVisible(NSMakeRange(0, 0))
        
        self.eventEntryConditions.scrollRectToVisible(CGRectMake(0, 0, 1, 1), animated: false)
        

        
        
//        let viewHeight = CGRectGetHeight(self.view.frame)
//        let viewWidth = CGRectGetWidth(self.view.frame)

        
        self.scrollView.delegate = self
//        self.scrollView.contentSize = CGSizeMake(viewWidth, viewHeight*2)
//        
//        self.scrollView.setContentOffset(CGPointMake(0, self.scrollView.contentOffset.y), animated: true)
//        self.scrollView.directionalLockEnabled = true

    
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        // GET Events
        let manager = AFHTTPRequestOperationManager()
        manager.GET("https://nightout.herokuapp.com/api/v1/events?",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
//                print("JSON: " + responseObject.description)
                let json = JSON(responseObject)
                
                
                let name = json["events"][0]["name"].string
//                print("SwiftyJSON: \(name)")
//                name!.uppercaseString
//                self.eventName.text! = name!
                
                let description = json["events"][0]["description"].string
//                print("SwiftyJSON: \(description)")
//                self.eventDescription.text! = description!
                
                let date = json["events"][0]["date"].string
//                print("SwiftyJSON: \(date)")
//                self.eventDate.text! = date!
                
                let time = json["events"][0]["start_time"].string
//                print("SwiftyJSON: \(time)")
//                self.eventTime.text! = time!
                
                let day = json["events"][0]["day"].string
//                print("SwiftyJSON: \(day)")
//                self.eventDate.text! = day!
                
                let location = json["events"][0]["location"].string
//                print("SwiftyJSON: \(location)")
//                self.eventLocation.text! = location!

                let entryCondition = json["events"][0]["entry_conditions"].string
//                print("SwiftyJSON: \(entryCondition)")
//                self.eventEntryConditions.text! = entryCondition!
                

                
//                if let eventArray = json["events"].array {
//                    var events = [EventModel]()
//                    
//                    for eventDict in eventArray {
//                        let eventName: String? = eventDict["name"].string
//                        let eventDescription: String? = eventDict["description"].string
//                        let eventDate: String? = eventDict["date"].string
//                        let eventTime: String? = eventDict["time"].string
//                        let eventDay: String? = eventDict["day"].string
//                        let eventLocation: String? = eventDict["location"].string
////                        let eventEntryCondition: Bool? = eventDict["above_18"].bool
//                        
//                        let event = EventModel(eventName: eventName, eventDescription: eventDescription, eventDate: eventDate, eventTime: eventTime, eventDay: eventDay, eventLocation: eventLocation, eventImage: nil)
//                        
//                        events.append(event)
//                    }
//                    print(events)
//                }
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                print("Error: " + error.localizedDescription)
                self.displayAlertMessage("Server Error", alertDescription: "Failed to get from server.")
        })
        
        
        
        // GET Bookings
        manager.GET("https://nightout.herokuapp.com/api/v1/bookings?",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
//                print("JSON: " + responseObject.description)
                let json = JSON(responseObject)
                
                
                let ticket_price = json["booking"][0]["amount"].int
//                print("SwiftyJSON: \(ticket_price)")
//                self.ticketPrice.text! = "\(ticket_price)"
                
                let ticket_type = json["booking"][0]["ticket_type"].string
//                print("SwiftyJSON: \(ticket_type)")
//                self.ticketType.text! = ticket_type!
                
//                if let bookingArray = json["bookings"].array {
//                    var bookings = [BookingModel]()
//                    
//                    for bookingDict in bookingArray {
//                        let offerID: Int? = bookingDict["offer_id"].int
//                        let ticketQuantity: Int? = bookingDict["quantity"].int
//                        let ticketPrice: Int? = bookingDict["amount"].int
//                        let ticketType: String? = bookingDict["ticker_type"].string
//                        
//                        let booking = BookingModel(offerID: offerID, ticketQuantity: ticketQuantity, ticketPrice: ticketPrice, ticketType: ticketType)
//                        
//                        bookings.append(booking)
//                    }
//                    print(bookings)
//                }

                
                
                
            },
            failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                print("Error: " + error.localizedDescription)
                self.displayAlertMessage("Server Error", alertDescription: "Failed to get from server.")
        })
        
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
    
    
    //Segue From Right
    @IBAction func segueToMe(segue: UIStoryboardSegue) {
        // segue back
    }
    
    override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue {
        
        if let id = identifier {
            if id == "returnToEventDetailVC" {
                let unwindSegue = UIStoryboardUnwindSegueFromRight(identifier: id, source: fromViewController, destination: toViewController)
                return unwindSegue
            }
        }
        
        return super.segueForUnwindingToViewController(toViewController, fromViewController: fromViewController, identifier: identifier)!
    }

}









