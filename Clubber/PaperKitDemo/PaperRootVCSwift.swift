//
//  PaperRootVCSwift.swift
//  Clubber
//
//  Created by Terra on 9/4/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit
import SwiftyJSON

class PaperRootVCSwift: PaperRootViewController, MenuTransitionManagerDelegate {
    
    //Temporary Fixed Images
    var backgroundImages: [UIImage] = [
        UIImage(named: "image")!,
        UIImage(named: "image1")!,
        UIImage(named: "image2")!,
        UIImage(named: "image3")!,
        UIImage(named: "image4")!,
        UIImage(named: "ImageCut")!,
        UIImage(named: "Cut")!
    ]
    
    //SwiftyJSON
    var events = [EventModel]()


    

    
    let colorX : UIColor = UIColor(red: (90/255.0), green: (225/255.0), blue: (200/255.0), alpha: 1.0) //custom Cyan Color
    var viewColor : UIColor = UIColor(red: (23/255.0), green: (23/255.0), blue: (23/255.0), alpha: 1.0)

    // UIAlertView Alert
    func displayAlertMessage(alertTitle:String, alertDescription:String) -> Void {
        let errorAlert = UIAlertView(title:alertTitle, message:alertDescription, delegate:nil, cancelButtonTitle:"OK")
        errorAlert.show()
    }
    
    // menu function
    private var menuTransitionManager = MenuTransitionManager()

    var activities = [ActivityModel]()
    
    // popover
    @IBOutlet var notificationButton: UIBarButtonItem!
    private var popover: Popover!
    private var popoverOptions: [PopoverOption] = [
        .Type(.Down),
        .BlackOverlayColor(UIColor(white: 0.0, alpha: 0.0))
    ]

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        // can try using this for the foreground View
//        self.collectionView.registerNib(UINib(nibName: "FriendsGoingCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: "FriendsGoingCollectionViewCell", withReuseIdentifier: "friendsGoingCollectionViewCell")
        
        let eventFeedCollectionViewCellNib = UINib(nibName: "EventFeedCollectionViewCell", bundle: nil)
        self.collectionView.registerNib(eventFeedCollectionViewCellNib, forCellWithReuseIdentifier: "eventFeedCollectionViewCell")

    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        let viewWidth = CGRectGetWidth(self.view.frame)
//        let viewHeight = CGRectGetHeight(self.view.frame)
//        
//        var screenRect: CGRect = UIScreen.mainScreen().bounds
//        var screenWidth: CGFloat = screenRect.size.width
//        var screenHeight: CGFloat = screenRect.size.height
        
        
        
        // Translucent NavigationBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
        // menu transitioning delegate
        self.title = ""
        
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if defaults.objectForKey("userLoggedIn") == nil {
            let signInViewController: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("signInVC")
            self.presentViewController(signInViewController, animated: true, completion: nil)
            
        } else {

            //GET Events
            let manager = AFHTTPRequestOperationManager()
            let url = "https://nightout.herokuapp.com/api/v1/events?"
            
            manager.requestSerializer = AFJSONRequestSerializer()
            
            manager.GET(url,
                parameters: nil,
                success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
//                    print("JSON: " + responseObject.description)
                    let json = JSON(responseObject)

                    if let eventArray = json["events"].array {
                        for eventDict in eventArray {
                            let eventName: String? = eventDict["name"].string
                            let eventDescription: String? = eventDict["description"].string
                            let eventDate: String? = eventDict["date"].string
                            let eventTime: String? = eventDict["time"].string
                            let eventDay: String? = eventDict["day"].string
                            let eventLocation: String? = eventDict["location"].string
                            let eventImage: String? = eventDict["image"].string
                            let eventEntryCondition: String? = eventDict["entry_conditions"].string
                            
                            let event = EventModel(eventName: eventName, eventDescription: eventDescription, eventDate: eventDate, eventTime: eventTime, eventDay: eventDay, eventLocation: eventLocation, eventImage: eventImage, eventEntryConditions: eventEntryCondition)
                            
                            self.events.append(event)
                        }
//                        print(self.events)
                    }
                    
                    self.reloadBackgroundData()

                    
                    
                    //                let selectedCatergoryUInt = Int(arc4random_uniform(26))
                    //                self.reloadForegroundDataOnCategory(selectedCatergoryUInt)
                    //                self.reloadForegroundDataOnCategory(selectedCategory)
                    
                    
                },
                failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                    print("Error: " + error.localizedDescription)
                    
                    self.displayAlertMessage("Server Error", alertDescription: "Error Retrieving Event")
                    
            })

            
            // check if API token has expired (No Token Expiry)
            //            let dateFormatter = NSDateFormatter()
            //            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            //            let userTokenExpiryDate : String? = KeychainAccess.passwordForAccount("Auth_Token_Expiry", service: "KeyChainService")
            //            let dateFromString : NSDate? = dateFormatter.dateFromString(userTokenExpiryDate!)
            //            let now = NSDate()
            //
            //            let comparision = now.compare(dateFromString!)
            
            // check if should fetch new data
            //            if shouldFetchNewData {
            //                shouldFetchNewData = false
            //                self.setNavigationItems()
            //                loadSelfieData()
            //            }
            
            //            // logout and ask user to sign in again if token is expired
            //            if comparision != NSComparisonResult.OrderedAscending {
            //                self.logoutBtnTapped()
            //            }
        }
    }
    
    
    
    //MARK: - SlideDownMenuProperties
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMenuFromRootPaper" {
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
    }
    

    // popover
    @IBAction func tappedRightBarButton(sender: UIBarButtonItem) {
        let startPoint = CGPoint(x: self.view.frame.width - 28, y: 55)
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 70))
        aView.backgroundColor = viewColor

        // display table view
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: aView.frame.width, height: aView.frame.height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollEnabled = true
        tableView.backgroundColor = viewColor
        tableView.separatorColor = UIColor.darkGrayColor()
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.rowHeight = 55
        self.popover = Popover(options: self.popoverOptions, showHandler: nil, dismissHandler: nil)

        aView.addSubview(tableView)
        
        self.popover.show(aView, point: startPoint)
        

    }
    
    
    // Background Collection View
    override func backgroundCollectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
            return self.events.count
    }
    
    override func backgroundCollectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("eventFeedCollectionViewCell", forIndexPath: indexPath) as! EventFeedCollectionViewCell
        cell.backgroundColor = UIColor.darkGrayColor()

        // Temporary
//        cell.eventNameLabel.text = ("Swift Feed \(indexPath.row)")
//        cell.eventLocationLabel.text = ("Swift Location \(indexPath.row)")
//        cell.eventDescriptionLabel.text = ("Swift Description \(indexPath.row)")
//        cell.eventImageView.image = self.backgroundImages[indexPath.row]
//        cell.eventImageView.image = UIImage(named: "Cut")

        
        var eventModel : EventModel
        eventModel = events[indexPath.row]
        
        cell.eventNameLabel.text! = eventModel.event_name
        cell.eventLocationLabel.text! = eventModel.event_location
        cell.eventDescriptionLabel.text! = eventModel.event_description
        
        cell.eventImageView.setImageWithURL(NSURL(string: ""), placeholer: UIImage(named: "Cut"), showActivityIndicatorView: true)
        
        
        
        
//        let i = collectionView.indexPathForCell(cell)!.row
//        if let eventDetailViewController: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("EventDetailVC") {
//            
//            let vc = UIStoryboardSegue!().destinationViewController as! EventDetailVC
//            vc.eventName.text = eventModel.event_name[i]
//            
//            self.presentViewController(eventDetailViewController, animated: true, completion: nil)
//        }

        
        
        
//        let mainFeedView = NSBundle.mainBundle().loadNibNamed("MainFeedView", owner: self, options: nil)[0] as! UIView
//        cell.backgroundView = mainFeedView
    
        
        
        
//        // Set Images using AFNetworking+UIImages (can try loading with Async Display also)
//        NSURL *url = [NSURL URLWithString:eventDictionary.image];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        UIImage *placeholderImage = [UIImage imageNamed:@"placeholderImage"];
//        
//        __weak MainFeedCollectionViewCell *weakCell = cell;
//        
//        [cell.mainFeedImageView setImageWithURLRequest:request
//        placeholderImage:placeholderImage
//        success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nonnull response, UIImage * _Nonnull image) {
//        weakCell.mainFeedImageView.image = image;
//        [weakCell setNeedsLayout];
//        
//        } failure:nil];
        

        
        
        
        // Tap on Event Collection View Cell
        let singleFingerTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        cell.addGestureRecognizer(singleFingerTap)

        return cell
    }
    
    // Tap on Event Collection View Cell
    func handleSingleTap(recognizer:UITapGestureRecognizer) {
        let eventDetailViewController: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("EventDetailVC")
        self.presentViewController(eventDetailViewController, animated: true, completion: nil)

    }
    

//    func backgroundCollectionView(collectionView: UICollectionView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("eventFeedCollectionViewCell", forIndexPath: indexPath) as! EventFeedCollectionViewCell
//
//        
//        let segue = UIStoryboardSegue!()
//        let sender = AnyObject!()
//
//        let selectedIndex = collectionView.indexPathForCell(sender as! EventFeedCollectionViewCell)
//    
//        
//        let eventDetailsVC: EventDetailVC = segue.destinationViewController as! EventDetailVC
//        eventDetailsVC.eventName.text = "Woohoof"
//        
//        
//    
//        let eventDetailViewController: UIViewController = self.storyboard!.instantiateViewControllerWithIdentifier("EventDetailVC")
//        self.presentViewController(eventDetailViewController, animated: true, completion: nil)
//        
//        return cell
//
//    }

    

    
    
//    // Foreground Collection View
//    override func numberOfSectionsInForegroundCollectionView(collectionView: UICollectionView!, onCategory category: Int) -> Int {
//        return 1
//    }
//    
//    override func foregroundCollectionVew(collectionView: UICollectionView!, numberOfItemsInSection section: Int, onCategory category: Int) -> Int {
//        return 10
//    }
    
    
    
//    func foregroundCollectionView(collectionView: PKCollectionView, contentViewControllerForAtIndexPath indexPath: NSIndexPath, onCategory category: UInt) -> PKContentViewController {
//
//        return CardViewController.new()
//    }
    

    
    
}


extension PaperRootVCSwift: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.popover.dismiss()
    }
}

extension PaperRootVCSwift: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.activities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        cell.backgroundColor = viewColor
        
        var activity : ActivityModel
        activity = activities[indexPath.row]

        
        let notificationImageView = UIImageView(frame: CGRectMake(8, 7, 40, 40))
        notificationImageView.layer.masksToBounds = true
        notificationImageView.layer.cornerRadius = notificationImageView.frame.size.width/2
        notificationImageView.clipsToBounds = true
        
        notificationImageView.image = activity.userImage
        cell.addSubview(notificationImageView)

        
        
        let viewWidth = CGRectGetWidth(self.view.frame)
    
        let notificationLabel = UILabel(frame: CGRectMake(56, 8, viewWidth - 64, 39))
        notificationLabel.text = activity.comment
        notificationLabel.font = UIFont(name: "AvenirNext-Regular", size: 14)
        notificationLabel.textColor = UIColor.whiteColor()
        notificationLabel.numberOfLines = 2
        notificationLabel.contentMode = UIViewContentMode.TopLeft
        cell.addSubview(notificationLabel)

        
        return cell
    }
}











