//
//  PaymentConfirmationViewController.swift
//  Clubber
//
//  Created by Terra on 8/24/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class PaymentConfirmationViewController: UIViewController {

    let paymentDetail = PaymentConfirmationTableViewController()

    // swipe to go back
    let swipeBack = UISwipeGestureRecognizer()
    
    @IBAction func back(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            NSLog("back")
        }
    }
    
    
    
    // UIAlertView Alert
    func displayAlertMessage(alertTitle:String, alertDescription:String) -> Void {
        let errorAlert = UIAlertView(title:alertTitle, message:alertDescription, delegate:nil, cancelButtonTitle:"OK")
        errorAlert.show()
    }
    
    
    @IBAction func confirmPaymentButtonPressed(sender: UIButton) {
//        makeBookingRequest()
        
        let QRViewController = self.storyboard!.instantiateViewControllerWithIdentifier("QRCodeNavVC") as! UINavigationController
        self.presentViewController(QRViewController, animated: true, completion: nil)

    }
    
    
    func makeBookingRequest() {
        let manager = AFHTTPRequestOperationManager()
        let url = "https://nightout.herokuapp.com/api/v1/events?"
        let bookingParams = [
//            "event[name]" : "\(self.paymentDetail.eventName.text!)",
//            "event[location]" : "\(self.paymentDetail.eventLocation.text!)",
//            "event[date]" : "\(self.paymentDetail.eventDate.text!)",
//            "event[time]" : "\(self.paymentDetail.eventTime.text!)",
            
//            "event[description]" : "",
//            "event[day]" : "",
//            "event[image]" : "",
//            "event[entry_conditions]" : ""
        ]
        

        manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.PUT(url,
            parameters: bookingParams,
            success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
//                print("Yes this was a success.. \(responseObject.description)")
                self.displayAlertMessage("Success!", alertDescription: "Your payment has been accepted. Have a wonderful night!")
                
                let QRViewController = self.storyboard!.instantiateViewControllerWithIdentifier("QRCodeNavVC") as! UINavigationController
                self.presentViewController(QRViewController, animated: true, completion: nil)
                
            },
            failure: { (operation: AFHTTPRequestOperation!, error: NSError!) in
                print("We got an error here.. \(error.localizedDescription)")
                self.displayAlertMessage("Error Connecting To Server", alertDescription: "Sorry, your transaction could not be completed. Please ensure you have a stable internet connection.")
        })
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // swipe to go back
        swipeBack.direction = UISwipeGestureRecognizerDirection.Right
        swipeBack.addTarget(self, action: "swipeBack:")
        self.view.addGestureRecognizer(swipeBack)
        
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
            if id == "returnToInviteFriendVC" {
                let unwindSegue = UIStoryboardUnwindSegueFromRight(identifier: id, source: fromViewController, destination: toViewController)
                return unwindSegue
            }
        }
        
        return super.segueForUnwindingToViewController(toViewController, fromViewController: fromViewController, identifier: identifier)!
    }
    
}
