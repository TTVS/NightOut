//
//  MessengerMainVC.swift
//  Clubber
//
//  Created by Terra on 9/2/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class MessengerMainVC: UIViewController, MenuTransitionManagerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UISearchControllerDelegate {
    
    var colorX : UIColor = UIColor(red: (90/255.0), green: (225/255.0), blue: (200/255.0), alpha: 1.0) //custom Cyan Color
    var colorY : UIColor = UIColor(red: (230/255.0), green: (48/255.0), blue: (66/255.0), alpha: 1.0) //custom Coral Red Color

    
    @IBAction func showActionSheet(sender: UIBarButtonItem) {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        let deleteAction = UIAlertAction(title: "Find Friend From Contacts", style: .Default, handler: {
            (alert: UIAlertAction) -> Void in
            print("Find Friend From Contacts")
        })
        let saveAction = UIAlertAction(title: "Find Friend From Facebook", style: .Default, handler: {
            (alert: UIAlertAction) -> Void in
            print("Find Friend From Facebook")
        })
    
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction) -> Void in
            print("Cancelled")
        })
        

        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        optionMenu.view.tintColor = colorX
        optionMenu.view.backgroundColor = UIColor.darkGrayColor()
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    // menu function
    private var menuTransitionManager = MenuTransitionManager()
    
    //search function
    var searchActive = false
    var friends = [FriendModel]()
    var filteredFriends = [FriendModel]()



    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
        
        // menu transitioning delegate
        self.title = "Messenger"
        
        
        //Table View
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.automaticallyAdjustsScrollViewInsets = false
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clearColor()
        
        self.tableView.backgroundView = backgroundView

        
        // friend array
        self.friends = [
            FriendModel(named: "Aurora", mood: "You: what do you think we can do today?", imageName: "A"),
            FriendModel(named: "Josephin", mood: "Aeve send a link.", imageName: "B"),
            FriendModel(named: "Elle", mood: "You: Thank you very much", imageName: "C"),
            FriendModel(named: "Marilyn", mood: "alright", imageName: "p1"),
            FriendModel(named: "Kain", mood: "You: That alternates between Mood and Conscience", imageName: "p2"),
            FriendModel(named: "Joseph", mood: "You: http://www.brianjcoleman.com", imageName: "p3"),
            FriendModel(named: "Kell", mood: "", imageName: "avatar1"),
            FriendModel(named: "Aeve", mood: "", imageName: "avatar2"),
            FriendModel(named: "Teresa", mood: "", imageName: "avatar3"),
            FriendModel(named: "Sarah", mood: "", imageName: "avatar4"),
            FriendModel(named: "Natalie", mood: "", imageName: "avatar5"),
            FriendModel(named: "Justin", mood: "", imageName: "avatar6"),
            FriendModel(named: "Bao", mood: "", imageName: "avatar7"),
            FriendModel(named: "Delsle", mood: "", imageName: "avatar8"),
            FriendModel(named: "Monr", mood: "", imageName: "avatar9")
        ]
        
        
        
        self.tableView.reloadData()
        
        
        //Search Bar
        searchBar.delegate = self
//        searchBar.becomeFirstResponder()
//        searchDisplayController?.setActive(true, animated: true)
        
        
        // search display controller (deprecated)
        searchDisplayController!.delegate = self
        searchDisplayController!.searchResultsDataSource = self
        searchDisplayController!.searchResultsDelegate = self



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    
    
    //MARK: - SlideDownMenuProperties
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMenuFromMessenger" {
            if let menuTableViewController = segue.destinationViewController as? SideMenuTableViewController {
                menuTableViewController.currentItem = self.title!
                
                // Assign animator
                self.menuTransitionManager.delegate = self
                menuTableViewController.transitioningDelegate = self.menuTransitionManager
            }
        }
        if segue.identifier == "segueModalDemoVC" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("navNav") as! UINavigationController
            
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    
    
    func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    
    //MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredFriends.count
            
        } else {
            return self.friends.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MessengerMainCell = self.tableView.dequeueReusableCellWithIdentifier("messengerCell") as! MessengerMainCell
        var friend : FriendModel
        
        if tableView == self.searchDisplayController!.searchResultsTableView {
            friend = filteredFriends[indexPath.row]
    
        } else {
            friend = friends[indexPath.row]
        }
        
        // Configure the cell
        cell.nameLabel.text = friend.name
        cell.statusLabel.text = friend.status
        cell.friendImage.image = friend.image
        
        //friendImageAttributes
        cell.friendImage.layer.cornerRadius = cell.friendImage.frame.size.height/2
        cell.friendImage.layer.masksToBounds = true
    
        return cell
    }

    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.section == 0 {
//            switch indexPath.row {
//            case 0:
//                self.performSegueWithIdentifier("segueModalDemoVC", sender: self)
//            case 1:
//                var vc: DemoMessagesViewController = DemoMessagesViewController.messagesViewController()
//                vc.delegateModal = self
//                var nc: UINavigationController = UINavigationController(rootViewController: vc)
//                self.presentViewController(nc, animated: true, completion: nil)
//            }
//        }

        
        
        //        var operandStack = NSMutableArray.new()
        //
        //        let indexPath = self.tableView.indexPathForSelectedRow()
        //        let currentCell = self.tableView.cellForRowAtIndexPath(indexPath!) as! InviteFriendCell
        //        var name = currentCell.nameLabel.text
        //
        //        if currentCell.selected == true {
        //            operandStack.addObject(name!)
        //        } else {
        //            operandStack.removeObject(name!)
        //        }
        //
        //
        //        NSLog("\(name)")
        
        //        println("You selected cell #\(indexPath!.row)!")
    }
    
    
    
    // Search Method 1
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredFriends = self.friends.filter({( friend : FriendModel) -> Bool in
            let stringMatch = friend.name.rangeOfString(searchText)
            return stringMatch != nil
        })
        
        if(filteredFriends.count == 0){
            searchActive = false
        } else {
            searchActive = true
        }
        self.tableView.reloadData()
    }
    

    func searchDisplayController(controller: UISearchDisplayController, didLoadSearchResultsTableView tableView: UITableView) {
        
        
        self.searchDisplayController!.searchResultsTableView.tableFooterView = UIView(frame: CGRectZero)
        self.searchDisplayController!.searchResultsTableView.rowHeight = self.tableView.rowHeight
        self.searchDisplayController!.searchResultsTableView.backgroundColor = self.tableView.backgroundColor
        self.searchDisplayController!.searchResultsTableView.separatorInset = self.tableView.separatorInset
        self.searchDisplayController!.searchResultsTableView.separatorColor = self.tableView.separatorColor
        self.searchDisplayController!.searchResultsTableView.allowsSelection = false
        
    }

}


































