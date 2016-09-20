//
//  MessengerTableViewControllerSwift.swift
//  Clubber
//
//  Created by Terra on 9/18/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit
import CoreData
import MessageDisplayKit

class MessengerTableViewControllerSwift: XHMessageTableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSFetchedResultsControllerDelegate, XHAudioPlayerHelperDelegate {
    
    var fetchedResultsController: NSFetchedResultsController!
    var managedObjectContext: NSManagedObjectContext!
    var emotionManagers = NSArray()
    
    var currentSelectedCell = XHMessageTableViewCell()
        
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
        
        self.messageSender = "Anonymous"
        self.navigationController?.interactivePopGestureRecognizer!.delaysTouchesBegan = false
        

        let messengerImage = UIImage(named: "avatar1")!
        let messengerFrame = CGRectMake(0, 0, 35, 35)
        let messageDetailButton: UIButton = UIButton(frame: messengerFrame)
        
        messageDetailButton.setBackgroundImage(messengerImage, forState: UIControlState.Normal)
        messageDetailButton.addTarget(self, action: "messageDetailButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        messageDetailButton.contentMode = UIViewContentMode.ScaleAspectFit
        
//        image = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)

        
        let profileDetailBarButton: UIBarButtonItem = UIBarButtonItem(customView: messageDetailButton)
        self.navigationItem.rightBarButtonItem = profileDetailBarButton
        

//        var color0: UIColor = UIColor(red: (84/255.0), green: (81/255.0), blue: (139/255.0), alpha: 1.0)
//        var color1 = UIColor(red: (55/255.0), green: (53/255.0), blue: (92/255.0), alpha: 1.0)
        let viewColor = UIColor(red: (30/255.0), green: (30/255.0), blue: (30/255.0), alpha: 1.0)
        self.setBackgroundColor(viewColor)
//        self.setBackgroundImage(UIImage(named: "cityBase"))
    
        
        
        let shareMenuItems: NSMutableArray = []
//        let plugIcons : NSArray = ["sharemore_pic", "sharemore_video", "sharemore_location", "sharemore_friendcard", "sharemore_myfav", "sharemore_wxtalk", "sharemore_videovoip", "sharemore_voiceinput", "sharemore_openapi", "sharemore_openapi", "avatar"]
//        let plugTitle : NSArray = ["照片", "拍摄", "位置", "名片", "我的收藏", "实时对讲机", "视频聊天", "语音输入", "大众点评", "应用", "曾宪华"]
//
//        //Original Obj C Code
//        for (NSString *plugIcon in plugIcons) {
//            XHShareMenuItem *shareMenuItem = [[XHShareMenuItem alloc] initWithNormalIconImage:[UIImage imageNamed:plugIcon] title:[plugTitle objectAtIndex:[plugIcons indexOfObject:plugIcon]]];
//            [shareMenuItems addObject:shareMenuItem];
//        }
//        
        //Swift Code
//        for plugIcon: NSString in plugIcons {
//            var shareMenuItem: XHShareMenuItem = XHShareMenuItem(normalIconImage: UIImage(named: plugIcon), title: plugTitle.objectAtIndex(plugIcons.indexOfObject(plugIcon)))
//            shareMenuItems.addObject(shareMenuItem)
//        }
        
        //Temporary Share Menu
        let shareMenuItem1 = XHShareMenuItem(normalIconImage: UIImage(named: "sharemore_pic"), title: "Photos")
        let shareMenuItem2 = XHShareMenuItem(normalIconImage: UIImage(named: "sharemore_video"), title: "Camera")
        shareMenuItems.addObject(shareMenuItem1)
        shareMenuItems.addObject(shareMenuItem2)
        
    
        
        //Emotions Manager
        let emotionManagers: NSMutableArray = []
        for var i = 0; i < 10; i++ {
            let emotionManager = XHEmotionManager()
            emotionManager.emotionName = "表情\(i)"
            let emotions: NSMutableArray = []
            for var j = 0; j < 32; j++ {
                let emotion = XHEmotion()
                let imageName = UIImage(named: "section\(i)_emotion\(j % 16)")
                emotion.emotionPath = NSBundle.mainBundle().pathForResource("Demo\(j % 2).gif", ofType: "")
                emotion.emotionConverPhoto = imageName
                emotions.addObject(emotion)
            }
            emotionManager.emotions = emotions
            emotionManagers.addObject(emotionManager)
        }
        self.emotionManagers = emotionManagers
        self.emotionManagerView!.reloadData()
        self.shareMenuItems = shareMenuItems as [AnyObject]
        self.shareMenuView!.reloadData()
        
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        XHAudioPlayerHelper.shareInstance().stopAudio

        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
        
    }
    
    // MARK: - Message Detail Button Pressed
    func messageDetailButtonPressed(sender:UIButton!) {
        print("messageDetailButtonPressed tapped")
        let profileDetailViewController: UIViewController = UIViewController()
        
        profileDetailViewController.view.backgroundColor = UIColor.greenColor()
        self.navigationController!.pushViewController(profileDetailViewController, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // ImagePickerSheetController (like iMessage)
//    override func didSelectedMultipleMediaAction() {
//        let presentImagePickerController: UIImagePickerControllerSourceType -> () = { source in
//            let controller = UIImagePickerController()
//            controller.delegate = self
//            var sourceType = source
//            if (!UIImagePickerController.isSourceTypeAvailable(sourceType)) {
//                sourceType = .PhotoLibrary
//                print("Fallback to camera roll as a source since the simulator doesn't support taking pictures")
//            }
//            controller.sourceType = sourceType
//            
//            self.presentViewController(controller, animated: true, completion: nil)
//        }
//        
//        let controller = ImagePickerSheetController(mediaType: .ImageAndVideo)
//        controller.addAction(ImagePickerAction(title: NSLocalizedString("Take Photo Or Video", comment: "Action Title"), secondaryTitle: NSLocalizedString("Add comment", comment: "Action Title"), handler: { _ in
//            presentImagePickerController(.Camera)
//            }, secondaryHandler: { _, numberOfPhotos in
//                print("Comment \(numberOfPhotos) photos")
//        }))
//        controller.addAction(ImagePickerAction(title: NSLocalizedString("Photo Library", comment: "Action Title"), secondaryTitle: { NSString.localizedStringWithFormat(NSLocalizedString("ImagePickerSheet.button1.Send %lu Photo", comment: "Action Title"), $0) as String}, handler: { _ in
//            presentImagePickerController(.PhotoLibrary)
//            }, secondaryHandler: { _, numberOfPhotos in
//                print("Send \(controller.selectedImageAssets)")
//        }))
//        controller.addAction(ImagePickerAction(title: NSLocalizedString("Cancel", comment: "Action Title"), style: .Cancel, handler: { _ in
//            print("Cancelled")
//        }))
//        
//        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
//            controller.modalPresentationStyle = .Popover
//            controller.popoverPresentationController?.sourceView = view
//            controller.popoverPresentationController?.sourceRect = CGRect(origin: view.center, size: CGSize())
//        }
//        
//        presentViewController(controller, animated: true, completion: nil)
//
//        self.layoutOtherMenuViewHiden(false)
//    }
    
    


    
    
    // MARK: - XHMessageTableViewCell Delegate
    override func multiMediaMessageDidSelectedOnMessage(message: XHMessageModel, atIndexPath indexPath: NSIndexPath, onMessageTableViewCell messageTableViewCell: XHMessageTableViewCell) {
        var disPlayViewController: UIViewController = UIViewController()
        
        switch message.messageMediaType() {
        case XHBubbleMessageMediaType.Video:
            NSLog("message : %@", message.videoConverPhoto())
            let messageDisplayTextView: XHDisplayMediaViewController = XHDisplayMediaViewController()
            messageDisplayTextView.message = message
            disPlayViewController = messageDisplayTextView
            disPlayViewController.view.backgroundColor = UIColor.blackColor()
            self.navigationController?.view.tintColor = UIColor.whiteColor()
            self.navigationController!.pushViewController(disPlayViewController, animated: true)
            break
            
        case XHBubbleMessageMediaType.Photo:
            NSLog("message : %@", message.photo())
            let messageDisplayTextView: XHDisplayMediaViewController = XHDisplayMediaViewController()
            messageDisplayTextView.message = message
            disPlayViewController = messageDisplayTextView
            disPlayViewController.view.backgroundColor = UIColor.blackColor()
            self.navigationController?.view.tintColor = UIColor.whiteColor()
            self.navigationController!.pushViewController(disPlayViewController, animated: true)
            break
            
        case XHBubbleMessageMediaType.Voice:
            NSLog("message : %@", message.voicePath())
////            var hasBeenRead = message.isRead!()
//            message.isRead!()
////            hasBeenRead = true
//            messageTableViewCell.messageBubbleView?.voiceUnreadDotImageView?.hidden = true
//
//            XHAudioPlayerHelper.shareInstance()
////            XHAudioPlayerHelper.shareInstance().delegate(self)
//            if self == currentSelectedCell {
//                currentSelectedCell.messageBubbleView?.animationVoiceImageView?.stopAnimating()
//            }
//            if currentSelectedCell == messageTableViewCell {
//                messageTableViewCell.messageBubbleView?.animationVoiceImageView?.stopAnimating()
//                messageTableViewCell.messageBubbleView?.animationVoiceImageView?.performSelector("stopAnimating", withObject: nil, afterDelay: 3)
//                XHAudioPlayerHelper.shareInstance().stopAudio()
////                self.currentSelectedCell = nil
//            }
//            else {
                self.currentSelectedCell = messageTableViewCell
                messageTableViewCell.messageBubbleView?.animationVoiceImageView?.startAnimating()
                XHAudioPlayerHelper.shareInstance().managerAudioWithFileName(message.voicePath(), toPlay: true)
                messageTableViewCell.messageBubbleView?.animationVoiceImageView?.performSelector("stopAnimating", withObject: nil, afterDelay: 3)
//            }
            break
            
        case XHBubbleMessageMediaType.Emotion:
            NSLog("facePath : %@", message.emotionPath())
            break
            
        case XHBubbleMessageMediaType.LocalPosition:
            NSLog("facePath : %@", message.localPositionPhoto())
            let displayLocationViewController: XHDisplayLocationViewController = XHDisplayLocationViewController()
            displayLocationViewController.message = message
            disPlayViewController = displayLocationViewController
            disPlayViewController.view.backgroundColor = UIColor.blackColor()
            self.navigationController?.view.tintColor = UIColor.whiteColor()
            self.navigationController!.pushViewController(disPlayViewController, animated: true)
            break
            
        default:
            break
            
        }
    }
    
//    override func didDoubleSelectedOnTextMessage(message: XHMessageModel, atIndexPath indexPath: NSIndexPath) {
//        NSLog("text : %@", message.text())
//        let displayTextViewController = XHDisplayTextViewController()
//        displayTextViewController.message = message
//        
//        self.navigationController!.pushViewController(displayTextViewController, animated: true)
//    }
    
    
    override func didSelectedAvatarOnMessage(message: XHMessageModel, atIndexPath indexPath: NSIndexPath) {
        NSLog("indexPath : %@", indexPath)
    }
    
    override func menuDidSelectedAtBubbleMessageMenuSelecteType(bubbleMessageMenuSelecteType: XHBubbleMessageMenuSelecteType) {
    }
    
    
    // MARK: -  XHAudioPlayerHelper Delegate
    
    func didAudioPlayerStopPlay(audioPlayer: AVAudioPlayer) {
        if currentSelectedCell == self {
            return
        }
        currentSelectedCell.messageBubbleView?.animationVoiceImageView?.stopAnimating()
//        self.currentSelectedCell = nil
    }
    
    
    // MARK: - XHEmotionManagerView DataSource
    
    override func numberOfEmotionManagers() -> Int {
        return self.emotionManagers.count
    }
    
    override func emotionManagerForColumn(column: Int) -> XHEmotionManager {
        return self.emotionManagers.objectAtIndex(column) as! XHEmotionManager
    }
    
    override func emotionManagersAtManager() -> [AnyObject] {
        return self.emotionManagers as [AnyObject]
    }
    
    
    // MARK: - XHMessageTableViewController DataSource
    
//    override func messageForRowAtIndexPath(indexPath: NSIndexPath!) -> XHMessageModel! {
////        var message: MDKMessage = self.fetchedResultsController.objectAtIndexPath(indexPath)
//        var currentMessage: XHMessage = XHMessage()
////        currentMessage.sender = message.sender
////        currentMessage.timestamp = message.timestamp
////        currentMessage.text = message.text
//        
//        
//        currentMessage.sender = "Melissa"
//        currentMessage.timestamp = NSDate()
//        currentMessage.text = "Lets hang out!"
//        
//        return currentMessage
//        
//    }
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
////        return self.fetchedResultsController.sections().count()
//        return 1
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        var sectionInfo: NSFetchedResultsSectionInfo = self.fetchedResultsController.sections()[section]
////        return sectionInfo.numberOfObjects()
//        return 3
//    }
//    
//    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return true
//    }
//    
////    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
////        if editingStyle == UITableViewCellEditingStyle.Delete {
////            var context: NSManagedObjectContext = self.fetchedResultsController.managedObjectContext()
////            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath))
////            var error: NSErrorPointer? = nil
////            if !context.save(&error) {
////                NSLog("Unresolved error %@, %@", error, error.userInfo())
////                abort()
////            }
////        }
////    }
//    
//    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        return false
//    }
    
    
    
    //    // MARK: - NSFetch Helper Method
    //    func insertNewObject(message: XHMessage) {
    //        var context: NSManagedObjectContext = self.fetchedResultsController.managedObjectContext
    //        var entity: NSEntityDescription = self.fetchedResultsController.fetchRequest.entity!
    //        var newManagedObject: NSManagedObject = NSEntityDescription.insertNewObjectForEntityForName(entity.name!, inManagedObjectContext: context) as! NSManagedObject
    //        newManagedObject.setValue(message.timestamp, forKey: "timestamp")
    //        newManagedObject.setValue(message.sender, forKeyPath: "sender")
    //        newManagedObject.setValue(message.text, forKeyPath: "text")
    //        var error: NSErrorPointer? = nil
    //        if context.save(error!) {
    //            NSLog("Unresolved error %@, %@", error!)
    ////                NSLog("Unresolved error %@, %@", error, error.userInfo())
    //            abort()
    //        }
    //    }
    //
    //
    
    
    
    // MARK: - Fetched Results Controller
//    func fetchedResultsController() -> NSFetchedResultsController {
//        if fetchedResultsController != nil {
//            return _fetchedResultsController
//        }
//        var fetchRequest: NSFetchRequest = NSFetchRequest()
//        var entity: NSEntityDescription = NSEntityDescription.entityForName("MDKMessage", inManagedObjectContext: self.managedObjectContext)!
//        fetchRequest.setEntity(entity)
//        fetchRequest.setFetchBatchSize(20)
//        var sortDescriptor: NSSortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false)
//        var sortDescriptors: [AnyObject] = [sortDescriptor]
//        fetchRequest.setSortDescriptors(sortDescriptors)
//        var aFetchedResultsController: NSFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: "Master")
//        aFetchedResultsController.delegate = self
//        self.fetchedResultsController = aFetchedResultsController
//        var error: NSErrorPointer? = nil
//        if !self.fetchedResultsController.performFetch(&error) {
//            NSLog("Unresolved error %@, %@", error, error.userInfo())
//            abort()
//        }
//        return _fetchedResultsController
//    }
//    
//    func controllerWillChangeContent(controller: NSFetchedResultsController) {
//        self.messageTableView.beginUpdates()
//    }
//    
//    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: UInt, forChangeType type: NSFetchedResultsChangeType) {
//        switch type {
//        case NSFetchedResultsChangeInsert:
//            self.messageTableView.insertSections(NSIndexSet.indexSetWithIndex(sectionIndex), withRowAnimation: UITableViewRowAnimationFade)
//        case NSFetchedResultsChangeDelete:
//            self.messageTableView.deleteSections(NSIndexSet.indexSetWithIndex(sectionIndex), withRowAnimation: UITableViewRowAnimationFade)
//        default:
//            break
//        }
//    }
//    
//    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
//        var tableView: UITableView = self.messageTableView
//        switch type {
//        case NSFetchedResultsChangeInsert:
//            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimationFade)
//        case NSFetchedResultsChangeDelete:
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimationFade)
//        case NSFetchedResultsChangeUpdate:
//            self.configureCell(tableView.cellForRowAtIndexPath(indexPath!), atIndexPath: indexPath)
//        case NSFetchedResultsChangeMove:
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimationFade)
//            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimationFade)
//        }
//    }
//    
//    func controllerDidChangeContent(controller: NSFetchedResultsController) {
//        self.messageTableView.endUpdates()
//    }
    
    

    
    // MARK: - XHMessageTableViewController Delegate
    override func shouldLoadMoreMessagesScrollToTop() -> Bool {
        return true
    }
    
//    override func loadMoreMessagesScrollTotop() {
//        if !self.loadingMoreMessage {
//            self.loadingMoreMessage = true
//            
//            
//            
//            let qualityOfServiceClass = QOS_CLASS_BACKGROUND
//            let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
//            dispatch_async(backgroundQueue, {
//                
//                var messages: [AnyObject] = self.getTestMessages()
//
//                println("This is run on the background queue")
//                
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    
//                    self.insertOldMessages(messages)
//                    self.loadingMoreMessage = false
//                    
//                    println("This is run on the main queue, after the previous code in outer block")
//                })
//            })
//    }
    
        
    
     override func didSendText(text: String, fromSender sender: String, onDate date: NSDate) {
        let textMessage: XHMessage = XHMessage(text: text, sender: sender, timestamp: date)
        textMessage.avatar = UIImage(named: "avatar1")
        self.addMessage(textMessage)
        self.finishSendMessageWithBubbleMessageType(XHBubbleMessageMediaType.Text)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    override func didSendPhoto(photo: UIImage, fromSender sender: String, onDate date: NSDate) {
        let photoMessage: XHMessage = XHMessage(photo: photo, thumbnailUrl: nil, originPhotoUrl: nil, sender: sender, timestamp: date)
        photoMessage.avatar = UIImage(named: "avatar1")
        self.addMessage(photoMessage)
        self.finishSendMessageWithBubbleMessageType(XHBubbleMessageMediaType.Photo)
    }
    
    override func didSendVideoConverPhoto(videoConverPhoto: UIImage, videoPath: String, fromSender sender: String, onDate date: NSDate) {
        let videoMessage: XHMessage = XHMessage(videoConverPhoto: videoConverPhoto, videoPath: videoPath, videoUrl: nil, sender: sender, timestamp: date)
        videoMessage.avatar = UIImage(named: "avatar1")
        self.addMessage(videoMessage)
        self.finishSendMessageWithBubbleMessageType(XHBubbleMessageMediaType.Video)
    }
    
    override func didSendVoice(voicePath: String, voiceDuration: String, fromSender sender: String, onDate date: NSDate) {
        let voiceMessage: XHMessage = XHMessage(voicePath: voicePath, voiceUrl: nil, voiceDuration: voiceDuration, sender: sender, timestamp: date)
        voiceMessage.avatar = UIImage(named: "avatar1")
        self.addMessage(voiceMessage)
        self.finishSendMessageWithBubbleMessageType(XHBubbleMessageMediaType.Voice)
    }
    
    override func didSendEmotion(emotionPath: String, fromSender sender: String, onDate date: NSDate) {
        if self == emotionPath {
            let emotionMessage: XHMessage = XHMessage(emotionPath: emotionPath, sender: sender, timestamp: date)
            emotionMessage.avatar = UIImage(named: "avatar1")
            self.addMessage(emotionMessage)
            self.finishSendMessageWithBubbleMessageType(XHBubbleMessageMediaType.Emotion)
        } else {
            let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func didSendGeoLocationsPhoto(geoLocationsPhoto: UIImage, geolocations: String, location: CLLocation, fromSender sender: String, onDate date: NSDate) {
        let geoLocationsMessage: XHMessage = XHMessage(localPositionPhoto: geoLocationsPhoto, geolocations: geolocations, location: location, sender: sender, timestamp: date)
        geoLocationsMessage.avatar = UIImage(named: "avatar1")
        self.addMessage(geoLocationsMessage)
        self.finishSendMessageWithBubbleMessageType(XHBubbleMessageMediaType.LocalPosition)
    }
    
    override func shouldDisplayTimestampForRowAtIndexPath(indexPath: NSIndexPath) -> Bool {
//        if indexPath.row == 0 {
//            return true
//        } else {
//            return false
//        }
        if indexPath.row == 0 || indexPath.row >= self.messages.count {
            return true
        }
        else {
            let message = self.messages.objectAtIndex(indexPath.row) as! XHMessage
            let previousMessage = self.messages.objectAtIndex(indexPath.row - 1) as! XHMessage
            let interval: Double = message.timestamp.timeIntervalSinceDate(previousMessage.timestamp)
            if interval > 60 * 3 {
                return true
            }
            else {
                return false
            }
        }

    }
    
    override func configureCell(cell: XHMessageTableViewCell, atIndexPath indexPath: NSIndexPath) {
        cell.messageBubbleView!.displayTextView!.textColor = UIColor(red: (50/255.0), green: (50/255.0), blue: (50/255.0), alpha: 1.0)
        
    }
    
    override func shouldPreventScrollToBottomWhileUserScrolling() -> Bool {
        return true
    }


    
}
