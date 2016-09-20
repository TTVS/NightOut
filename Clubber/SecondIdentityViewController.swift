//
//  FriendProfileViewController.swift
//  Clubber
//
//  Created by Terra on 6/10/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class FriendProfileViewController: UIViewController, MenuTransitionManagerDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIGestureRecognizerDelegate, MHFacebookImageViewerDatasource {
    
    
    var imageDataSource: MHFacebookImageViewerDatasource!
    
    var collectionViewImage: [UIImage] = [
        UIImage(named: "image")!,
        UIImage(named: "image1")!,
        UIImage(named: "image2")!,
        UIImage(named: "image3")!,
        UIImage(named: "image4")!,
        UIImage(named: "demo")!
    ]

    //collection view
    @IBOutlet var collectionView: UICollectionView!

    private var menuTransitionManager = MenuTransitionManager()

    @IBOutlet var menuButton: UIBarButtonItem!
    
    // Go Back To Previous VC
    @IBAction func back(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            NSLog("back")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
        
        // navigation bar title
        self.title = "Second Identity"

        
        // Side Menu Properties
//        if self.revealViewController() != nil {
//            menuButton.target = self.revealViewController()
//            menuButton.action = "revealToggle:"
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        }
//        self.revealViewController().rearViewRevealWidth = 250
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - SlideMenuProperties
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showMenuFromSecondID" {
            if let menuTableViewController = segue.destinationViewController as? SideMenuTableViewController {
                menuTableViewController.currentItem = self.title!
                
                // Assign animator
                self.menuTransitionManager.delegate = self
                menuTableViewController.transitioningDelegate = self.menuTransitionManager
            }
        } else if segue.identifier == "showProfileSettings" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("ProfileSettingsNavigationViewController") as! UINavigationController
            
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    //MARK: - UICollectionView
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return collectionViewImage.count
        return numberImagesForImageViewer(MHFacebookImageViewer())
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as! FriendImagesCollectionViewCell
        
//        var imageView: UIImageView = cell.viewWithTag(1)
//        imageView.image = UIImage(named: "\(indexPath.row).png")
//        imageView.contentMode = UIViewContentMode.ScaleAspectFill
//        imageView.setupImageViewer()
//        imageView.clipsToBounds = true

        
//        var imageView1 = cell.pictureImageView.viewWithTag(1)
//        cell.pictureImageView.image = UIImage(named: "\(indexPath.row).png")
        cell.pictureImageView.image = collectionViewImage[indexPath.row]
        cell.pictureImageView.contentMode = UIViewContentMode.ScaleAspectFill
        cell.pictureImageView.clipsToBounds = true

        cell.pictureImageView.setupImageViewerWithDatasource(self, initialIndex: indexPath.row, onOpen: { () -> Void in
            print("MHFacebook Opened!")
        }) { () -> Void in
            print("MHFacebook Closed!")
        }

        
        return cell
    }
    
    func numberImagesForImageViewer(imageViewer: MHFacebookImageViewer!) -> Int {
        return collectionViewImage.count
    }
    
    func imageURLAtIndex(index: Int, imageViewer: MHFacebookImageViewer!) -> NSURL! {
        return nil
    }
    
    func imageDefaultAtIndex(index: Int, imageViewer: MHFacebookImageViewer!) -> UIImage! {
        return collectionViewImage[index]
    }
}









