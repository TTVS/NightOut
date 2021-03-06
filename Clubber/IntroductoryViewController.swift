//
//  IntroductoryViewController.swift
//  Clubber
//
//  Created by Terra on 6/1/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class IntroductoryViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var pageTitles: NSArray!
    var pageImages: NSArray!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageTitles = NSArray(objects: "", "", "")
        self.pageImages = NSArray(objects: "walkthroughPage", "walkthroughPage", "walkthroughPage")
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("IntroPageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(0) as IntroductoryContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.size.height)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
    }
    
    
    func dismissTutorial() -> Void {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func restartAction(sender: AnyObject) {
        
        let startVC = self.viewControllerAtIndex(0) as IntroductoryContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
    }
    
    
    func viewControllerAtIndex(index: Int) -> IntroductoryContentViewController {
        
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count))
        {
            return IntroductoryContentViewController()
        }
        
        let vc: IntroductoryContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("introductoryContentVC") as! IntroductoryContentViewController
        
        vc.imageFile = self.pageImages[index] as! String
        vc.titleText = self.pageTitles[index] as! String
        vc.pageIndex = index
        
        return vc
        
    }
    
    
    //MARK: - Page View Controller Data Source
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! IntroductoryContentViewController
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        index--
        return self.viewControllerAtIndex(index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! IntroductoryContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound) {
            return nil
        }
        
        index++
        
        if (index == self.pageTitles.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
        
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }    
}
