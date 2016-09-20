//
//  AppDelegate.swift
//  Clubber
//
//  Created by Alireza Samar on 5/8/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit
import CoreData
import FBSDKCoreKit
//import AFNetworking
//import Alamofire
//import FastImageCache

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
//, FICImageCacheDelegate {

    var window: UIWindow?
    var frontWindow: UIWindow?
//    var signInWindow: UIWindow?
//    var signUpWindow: UIWindow?
//    var forgotPWWindow: UIWindow?
//    var introductoryContentWindow: UIWindow?
    
    lazy var coreDataStack = CoreDataStack()

    // Old Custom Colors
    var myColor1 : UIColor = UIColor(red: (29/255.0), green: (184/255.0), blue: (174/255.0), alpha: 1.0)
    var myColor2 : UIColor = UIColor(red: (47/255.0), green: (66/255.0), blue: (86/255.0), alpha: 1.0)
    var myColor3 : UIColor = UIColor(red: (255/255.0), green: (204/255.0), blue: (59/255.0), alpha: 1.0)

    // Custom Colors
    var navColor : UIColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (29/255.0), alpha: 1.0)
    var viewColor : UIColor = UIColor(red: (23/255.0), green: (23/255.0), blue: (23/255.0), alpha: 1.0)
    var colorY : UIColor = UIColor(red: (230/255.0), green: (48/255.0), blue: (66/255.0), alpha: 1.0) //custom Coral Red Color
    var colorX : UIColor = UIColor(red: (90/255.0), green: (225/255.0), blue: (200/255.0), alpha: 1.0) //custom Cyan Color
    var fbColor : UIColor = UIColor(red: (61/255.0), green: (84/255.0), blue: (152/255.0), alpha: 1.0)

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        // Make universal navigation bar tint
        UINavigationBar.appearance().barTintColor = UIColor.blackColor()
        UINavigationBar.appearance().tintColor = colorX
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName : UIFont(name: "AvenirNext-Regular", size: 18)!]

        
        // Set status bar white
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        
        //IntroductoryPageController
        let pageController = UIPageControl.appearance()
        pageController.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageController.currentPageIndicatorTintColor = colorX
        pageController.backgroundColor = UIColor.clearColor()
        
        //FastImageCache
//        FastImageCacheHelper.setUp(self)
//        let navController = window!.rootViewController as! UINavigationController
//        let photoBrowserCollectionViewController = navController.topViewController as! PhotoBrowserCollectionViewController
//        photoBrowserCollectionViewController.coreDataStack = coreDataStack
        
        //MARK: - New Swipe Menu
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        let front:UIViewController =  storyboard.instantiateViewControllerWithIdentifier("frontViewController") as! UIViewController
//        frontWindow = UIWindow(frame: UIScreen.mainScreen().bounds)
//        frontWindow?.rootViewController = front
//        frontWindow?.windowLevel = UIWindowLevelStatusBar
//        frontWindow?.startSwipeToOpenMenu()
//        frontWindow?.makeKeyAndVisible()
        
        
//        let signIn:UIViewController =  storyboard.instantiateViewControllerWithIdentifier("signInVC") as! SignInViewController
//        signInWindow?.stopSwipeToOpenMenu()
//
//        let signUp:UIViewController =  storyboard.instantiateViewControllerWithIdentifier("signUpVC") as! SignUpViewController
//        signUpWindow?.stopSwipeToOpenMenu()
//
//        let forgotPW:UIViewController =  storyboard.instantiateViewControllerWithIdentifier("forgotPWVC") as! ForgotPWViewController
//        forgotPWWindow?.stopSwipeToOpenMenu()
//
//        let introductoryContent:UIViewController =  storyboard.instantiateViewControllerWithIdentifier("introductoryContentVC") as! IntroductoryContentViewController
//        introductoryContentWindow?.stopSwipeToOpenMenu()
        
//        frontWindow?.layer.masksToBounds = true
//        let maskPath = UIBezierPath(roundedRect: UIScreen.mainScreen().bounds, byRoundingCorners: (.TopLeft | .TopRight), cornerRadii: CGSizeMake(2.0, 2.0))
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = UIScreen.mainScreen().bounds
//        maskLayer.path = maskPath.CGPath
//        frontWindow?.layer.mask = maskLayer
    
        AFNetworkActivityIndicatorManager.sharedManager().enabled = true
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
//        return true
    }
    
//    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
//        
//        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
//    }



    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        coreDataStack.saveContext()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
        coreDataStack.saveContext()
    }

    // MARK: - Core Data stack
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "dinomedia.asia.Clubber" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] 
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Clubber", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("Clubber.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch let error1 as NSError {
                    error = error1
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    NSLog("Unresolved error \(error), \(error!.userInfo)")
                    abort()
                }
            }
        }
    }
    
//    //MARK: FICImageCacheDelegate
//    
//    func imageCache(imageCache: FICImageCache!, wantsSourceImageForEntity entity: FICEntity!, withFormatName formatName: String!, completionBlock: FICImageRequestCompletionBlock!) {
//        if let entity = entity as? PhotoInfo {
//            let imageURL = entity.sourceImageURLWithFormatName(formatName)
//            let request = NSURLRequest(URL: imageURL)
//            
//            entity.request = Alamofire.request(.GET, request).validate(contentType: ["image/*"]).responseImage() {
//                (_, _, image, error) in
//                if (error == nil) {
//                    completionBlock(image)
//                }
//            }
//        }
//    }
//    
//    func imageCache(imageCache: FICImageCache!, cancelImageLoadingForEntity entity: FICEntity!, withFormatName formatName: String!) {
//        
//        if let entity = entity as? PhotoInfo, request = entity.request {
//            request.cancel()
//            entity.request = nil
//            //println("be canceled:\(entity.UUID)")
//        }
//    }
//    
//    func imageCache(imageCache: FICImageCache!, shouldProcessAllFormatsInFamily formatFamily: String!, forEntity entity: FICEntity!) -> Bool {
//        return true
//    }
//    
//    func imageCache(imageCache: FICImageCache!, errorDidOccurWithMessage errorMessage: String!) {
//        println("errorMessage" + errorMessage)
//    }
//

}

