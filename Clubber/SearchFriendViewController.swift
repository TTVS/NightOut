//
//  SearchFriendViewController.swift
//  Clubber
//
//  Created by Terra on 6/17/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class SearchFriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, UISearchControllerDelegate {
    
    var colorY : UIColor = UIColor(red: (230/255.0), green: (48/255.0), blue: (66/255.0), alpha: 1.0) //custom Coral Red Color
    var colorX : UIColor = UIColor(red: (90/255.0), green: (225/255.0), blue: (200/255.0), alpha: 1.0) //custom Cyan Color

    
    // popover
    @IBOutlet var addButton: UIBarButtonItem!
    
    private var texts = ["Find Friend From Contacts", "Add Friend"]
    private var popover: Popover!
    private var popoverOptions: [PopoverOption] = [
        .Type(.Down),
        .BlackOverlayColor(UIColor(white: 0.0, alpha: 0.0))
    ]
    
    @IBAction func showActionSheet(sender: UIBarButtonItem) {
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .ActionSheet)
        let deleteAction = UIAlertAction(title: "Find Friend From Contacts", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Find Friend From Contacts")
        })
        let saveAction = UIAlertAction(title: "Find Friend From Facebook", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Find Friend From Facebook")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        
        optionMenu.view.tintColor = colorX
        optionMenu.view.backgroundColor = UIColor.darkGrayColor()
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    
    // swipe to go back
    let swipeBack = UISwipeGestureRecognizer()

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    @IBAction func back(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            NSLog("back")
        }
    }
    
    
    //    var resultSearchController = UISearchController()
    var searchActive = false
    var friends = [FriendModel]()
    var filteredFriends = [FriendModel]()
    
    
//    // Keyboard Appear as ViewDidAppear
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(true)
//        self.showKeyboard()
//    }
    
    func showKeyboard() {
        self.searchBar.becomeFirstResponder()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // swipe to go back
        swipeBack.direction = UISwipeGestureRecognizerDirection.Right
        swipeBack.addTarget(self, action: "swipeBack:")
        self.view.addGestureRecognizer(swipeBack)
        
        

        //Table View
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: CGRectZero)
        self.automaticallyAdjustsScrollViewInsets = false
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clearColor()
        
        self.tableView.backgroundView = backgroundView
        
        
        //Search Bar
        searchBar.delegate = self
//        searchBar.becomeFirstResponder()
//        searchDisplayController?.setActive(true, animated: true)
        
        
        // search display controller (deprecated)
        searchDisplayController!.delegate = self
        searchDisplayController!.searchResultsDataSource = self
        searchDisplayController!.searchResultsDelegate = self
        
        
        // preparing nib file
        let nib = UINib(nibName: "InviteFriendCell", bundle: nil)
        self.searchDisplayController!.searchResultsTableView.registerNib(nib, forCellReuseIdentifier: "friendCell")
        self.tableView.registerNib(nib, forCellReuseIdentifier: "friendCell")
        
        
        //search controller delegate
        //        self.resultSearchController = ({
        //            let controller = UISearchController(searchResultsController: nil)
        //
        //            controller.searchResultsUpdater = self
        //            controller.hidesNavigationBarDuringPresentation = false
        //            controller.dimsBackgroundDuringPresentation = false
        //            controller.searchBar.sizeToFit()
        //            self.tableView.tableHeaderView = controller.searchBar
        //
        //            return controller
        //
        //        })()
        
        
        // friend array
        self.friends = [
            FriendModel(named: "Aurora", mood: "Big Spender", imageName: "A"),
            FriendModel(named: "Aeve", mood: "excited", imageName: "B"),
            FriendModel(named: "Aiel", mood: "happy", imageName: "C"),
            FriendModel(named: "Marilyn", mood: "melancholy", imageName: "p1"),
            FriendModel(named: "Kain", mood: "nondescript", imageName: "p2"),
            FriendModel(named: "Joseph", mood: "alright", imageName: "p3"),
            FriendModel(named: "Aurora", mood: "joyous", imageName: "A"),
            FriendModel(named: "Aeve", mood: "excited", imageName: "B"),
            FriendModel(named: "Aiel", mood: "happy", imageName: "C"),
            FriendModel(named: "Marilyn", mood: "melancholy", imageName: "p1"),
            FriendModel(named: "Kain", mood: "nondescript", imageName: "p2"),
            FriendModel(named: "Aurora", mood: "joyous", imageName: "A"),
            FriendModel(named: "Aeve", mood: "excited", imageName: "B"),
            FriendModel(named: "Aiel", mood: "happy", imageName: "C"),
            FriendModel(named: "Marilyn", mood: "melancholy", imageName: "p1"),
            FriendModel(named: "Kain", mood: "nondescript", imageName: "p2"),
            FriendModel(named: "Joseph", mood: "alright", imageName: "p3"),
            FriendModel(named: "Aurora", mood: "joyous", imageName: "A"),
            FriendModel(named: "Aeve", mood: "excited", imageName: "B"),
            FriendModel(named: "Aiel", mood: "happy", imageName: "C"),
            FriendModel(named: "Marilyn", mood: "melancholy", imageName: "p1"),
            FriendModel(named: "Kain", mood: "nondescript", imageName: "p2")
        ]
        
        
        self.tableView.reloadData()
        
    }
    
    
    
    // MARK: UISearchResultsUpdating
    //    func updateSearchResultsForSearchController(searchController: UISearchController) {
    //        filteredFriends.removeAll(keepCapacity: false)
    //
    //        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
    //        let array = (friends as NSArray).filteredArrayUsingPredicate(searchPredicate)
    //        filteredFriends = array as! [(FriendModel)]
    //
    //        self.tableView.reloadData()
    //
    //    }
    
    
    
    
    
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
            if id == "returnToTableSelectionVC" {
                let unwindSegue = UIStoryboardUnwindSegueFromRight(identifier: id, source: fromViewController, destination: toViewController)
                return unwindSegue
            }
        }
        
        return super.segueForUnwindingToViewController(toViewController, fromViewController: fromViewController, identifier: identifier)!
    }
    
    

    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if (self.resultSearchController.active) {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredFriends.count
        } else {
            return self.friends.count
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: InviteFriendCell = self.tableView.dequeueReusableCellWithIdentifier("friendCell") as! InviteFriendCell
        
        var friend : FriendModel
        //        if (self.resultSearchController.active) {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            friend = filteredFriends[indexPath.row]
        } else {
            friend = friends[indexPath.row]
        }
        
        // Configure the cell
        
        cell.nameLabel.text = friend.name
        cell.statusLabel.text = friend.status
        cell.friendImage.image = friend.image
        
        
        
        
        // inviteButton selection (OLD)
//        cell.inviteButton.setTitle("Invite", forState: UIControlState.Highlighted)
//        cell.inviteButton.setTitle("", forState: UIControlState.Selected)
//        cell.inviteButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//
//        cell.inviteButton.setBackgroundImage(UIImage(named: "inviteButtonOri"), forState: UIControlState.Highlighted)
//        cell.inviteButton.setBackgroundImage(UIImage(named: "inviteButtonDisabled"), forState: UIControlState.Selected)
        
        cell.inviteButton.setBackgroundImage(UIImage(named: "checkBox"), forState: UIControlState.Normal)
        cell.inviteButton.setBackgroundImage(UIImage(named: "checkBoxActive"), forState: UIControlState.Selected)
        cell.inviteButton.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)

        // friendButton selection (INACTIVE)
//        cell.friendButton.setBackgroundImage(UIImage(named: "selectedImage"), forState: UIControlState.Selected)
//        cell.friendButton.setBackgroundImage(UIImage(named: "imageNormal"), forState: UIControlState.Normal)
//        
//        cell.friendButton.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        //friendImage Attributes
        cell.friendImage.layer.cornerRadius = cell.friendImage.frame.size.height/2
        cell.friendImage.layer.masksToBounds = true
        
        
        // friendButton Attributes
        //        cell.friendButton.layer.cornerRadius = cell.friendButton.frame.size.height/2
        //        cell.friendButton.layer.masksToBounds = true
        
        
        // Cell Highlighted (Works when the selection is not multiple, if it's multiple with each selection the previos one disappear)
        
        return cell
    }
    
    // friendButton clicked
    func buttonClicked(sender:UIButton) {
        sender.selected = !sender.selected
    }
    

    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.popover.dismiss()

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
    
    
    // make an operand stack that can addObject or append nameLabel of new cell selected
    
    
    
    
    //        let cell: InviteFriendCell = self.tableView.dequeueReusableCellWithIdentifier("friendCell") as! InviteFriendCell
    //        var friend : FriendModel
    //        var operandStack = Array<String>()
    //
    //        // friendButtonState
    //        var selectedButtonState = cell.friendButton.selected
    //        var buttonNotSelected = cell.friendButton
    //        var selectedStateArray = []
    //
    //        var displayName = currentCell.nameLabel.text
    //
    //        if (buttonNotSelected != nil) {
    //            operandStack.append(displayName!)
    //            println("operandStack = \(operandStack)")
    //
    //        } else if selectedButtonState {
    //            operandStack.removeLast()
    //            println("operandStack = \(operandStack)")
    //
    //        }
    
    
    
    
    //        operandStack[operandStack.endIndex - 1]
    
    //        var displayValue: String {
    //            get {
    //                return friend.name
    //            } set {
    //                operandStack.text = "\(newValue)"
    //                selectedButtonState = false
    //            }
    //        }
    
    //       let foundInde = find(friend, (friend.name).toInt())
    //        foundIndex = find(self.friends!, friend) {
    //
    //                //remove the item at the found index
    //                self.friends!.removeAtIndex(foundIndex)
    //
    //            }
    //
    //        }
    
    
    
    
    
    //END
    
    // we want to get the buttonSelected and add it to the array of buttons selected of the names in the cell
    // so when i click the friendButton, the operandStack will keep on adding the array of names from the cell. (selected state)
    // (non-selected state), it will un-append it from there
    
    
    //    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
    //        let indexPath = self.tableView.indexPathForSelectedRow()
    //        let currentCell = self.tableView.cellForRowAtIndexPath(indexPath!) as! ProfileCell
    //
    //        println(currentCell.nameLabel!.text)
    //    }
    
    
    
    
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
    
    
    // Search Method 2
    
    //    func filterContentForSearchText(searchText: String) {
    //        self.filteredFriends = self.friends.filter({( friend : FriendModel) -> Bool in
    //            var stringMatch = friend.name.rangeOfString(searchText)
    //            return stringMatch != nil
    //        })
    //    }
    //
    //    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
    //        self.filterContentForSearchText(searchString)
    //        return true
    //    }
    
    func searchDisplayController(controller: UISearchDisplayController, didLoadSearchResultsTableView tableView: UITableView) {
        
        
        self.searchDisplayController!.searchResultsTableView.tableFooterView = UIView(frame: CGRectZero)
        self.searchDisplayController!.searchResultsTableView.rowHeight = self.tableView.rowHeight
        self.searchDisplayController!.searchResultsTableView.backgroundColor = self.tableView.backgroundColor
        self.searchDisplayController!.searchResultsTableView.separatorInset = self.tableView.separatorInset
        self.searchDisplayController!.searchResultsTableView.separatorColor = self.tableView.separatorColor
        self.searchDisplayController!.searchResultsTableView.allowsSelection = false
        
    }
    
    
    
    // popover
    @IBAction func tappedRightBarButton(sender: UIBarButtonItem) {
        let startPoint = CGPoint(x: self.view.frame.width - 28, y: 55)
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 180))
        aView.backgroundColor = UIColor.darkGrayColor()
        
        
        // display table view
//        addTableView = UITableView(frame: CGRect(x: 0, y: 0, width: aView.frame.width, height: aView.frame.height))
//        addTableView.delegate = self
//        addTableView.dataSource = self
//        addTableView.scrollEnabled = true
//        addTableView.backgroundColor = UIColor.clearColor()
//        addTableView.separatorColor = UIColor.darkGrayColor()
//        self.popover = Popover(options: self.popoverOptions, showHandler: nil, dismissHandler: nil)
//        
//        aView.addSubview(addTableView)
        let popover = Popover()
        popover.show(aView, point: startPoint)
        
        
        // display balloon
        //        let width = self.view.frame.width / 4
        //        let aView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        //        let options = [
        //            .Type(.Up),
        //            .CornerRadius(width / 2)
        //            ] as [PopoverOption]
        //        var popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
        //        popover.show(aView, fromView: self.addButton)
        
    }
}

//
//extension SearchFriendViewController: UITableViewDelegate {
//    
//    func addTableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        self.popover.dismiss()
//    }
//}
//
//extension SearchFriendViewController: UITableViewDataSource {
//    
//    func addTableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        return texts.count
//    }
//    
//    func addTableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .Default, reuseIdentifier: nil)
//        cell.backgroundColor = UIColor.clearColor()
//        cell.textLabel?.text = self.texts[indexPath.row]
//        cell.textLabel?.textColor = UIColor.darkGrayColor()
//        return cell
//    }
//}
