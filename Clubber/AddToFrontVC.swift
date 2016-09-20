//
//  SlideMenuViewController.swift
//  Clubber
//
//  Created by Terra on 8/5/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

// add these to HANavigationController.m

import UIKit

class HANavigationController: UIViewController,  MenuTransitionManagerDelegate {

    
    private var menuTransitionManager = MenuTransitionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Feed"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: - SlideMenuProperties
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let menuTableViewController = segue.destinationViewController as! MenuTableViewController
        menuTableViewController.currentItem = self.title!
        
        // Assign animator
        self.menuTransitionManager.delegate = self
        menuTableViewController.transitioningDelegate = self.menuTransitionManager
    }
    
    func dismiss() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        let sourceController = segue.sourceViewController as! MenuTableViewController
        self.title = sourceController.currentItem
    }
    



}
