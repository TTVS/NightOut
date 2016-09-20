//
//  TableSelectionVC.swift
//  Clubber
//
//  Created by Terra on 8/18/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class TableSelectionVC: UIViewController, UIScrollViewDelegate {
    
    // swipe to go back
    let swipeBack = UISwipeGestureRecognizer()
    
    
    
    // symbol scroll view
    @IBOutlet var tableSymbolScrollView: UIScrollView!
    @IBOutlet var tableSymbolImageView: UIImageView!
    
    //var symbolImageView: UIImageView!
    //var symbolScrollView: UIScrollView!
    @IBOutlet var tableSymbolView: UIView!
    
    
    // table layout scroll view
    var tableLayoutImageView: UIImageView!
    var tableLayoutScrollView: UIScrollView!
    @IBOutlet var tableLayoutView: UIView!

    
    @IBAction func back(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
            NSLog("back")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // swipe to go back
        swipeBack.direction = UISwipeGestureRecognizerDirection.Right
        swipeBack.addTarget(self, action: "swipeBack:")
        self.view.addGestureRecognizer(swipeBack)
        
        
        // table Symbol Scroll View
//        symbolImageView = UIImageView(image: UIImage(named: "tableSymbol"))
//        
//        symbolScrollView = UIScrollView(frame: tableSymbolView.bounds)
//        symbolScrollView.backgroundColor = UIColor.blackColor()
//        symbolScrollView.contentSize = symbolImageView.bounds.size
//        symbolScrollView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
//        
//        symbolScrollView.scrollEnabled = true
//        symbolScrollView.showsHorizontalScrollIndicator = true
//        
//        symbolScrollView.addSubview(symbolImageView)
//        tableSymbolView.addSubview(symbolScrollView)
        
        
        
        // table Layout Scroll View
        tableLayoutImageView = UIImageView(image: UIImage(named: "demo"))
        
        tableLayoutScrollView = UIScrollView(frame: tableLayoutView.bounds)
        tableLayoutScrollView.backgroundColor = UIColor.blackColor()
        tableLayoutScrollView.contentSize = tableLayoutImageView.bounds.size
        
        tableLayoutScrollView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        tableLayoutScrollView.contentOffset = CGPoint(x: tableLayoutImageView.frame.width/2, y: tableLayoutImageView.frame.height/2)
        
        tableLayoutScrollView.showsHorizontalScrollIndicator = true
        tableLayoutScrollView.showsVerticalScrollIndicator = true
        tableLayoutScrollView.indicatorStyle = UIScrollViewIndicatorStyle.White
        
        tableLayoutScrollView.addSubview(tableLayoutImageView)
        tableLayoutView.addSubview(tableLayoutScrollView)
        
        tableLayoutScrollView.delegate = self
        
        setZoomScale()
        setupGestureRecognizer()
        
        
        // to set static zoom scale
//        tableLayoutScrollView.minimumZoomScale = 0.1
//        tableLayoutScrollView.maximumZoomScale = 2.0
//        tableLayoutScrollView.zoomScale = 1.0
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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
    
    
    
    //MARK: - Scroll View Zooming
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return tableLayoutImageView
    }
    
    // gets dynamic zoom scale
    func setZoomScale() {
        let imageViewSize = tableLayoutImageView.bounds.size
        let scrollViewSize = tableLayoutScrollView.bounds.size
        
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        tableLayoutScrollView.minimumZoomScale = min(widthScale, heightScale)
        tableLayoutScrollView.zoomScale = 1.0
    }
    
    // centers the image view when zoomed out (need to fix)
    func scrollViewDidZoom(scrollView: UIScrollView) {
        let imageViewSize = tableLayoutImageView.frame.size
        let scrollViewSize = tableLayoutScrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        tableLayoutScrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
    
    func setupGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: self, action: "handleDoubleTap:")
        doubleTap.numberOfTapsRequired = 2
        tableLayoutScrollView.addGestureRecognizer(doubleTap)
    }
    
    func handleDoubleTap(recognizer: UITapGestureRecognizer) {
        if (tableLayoutScrollView.zoomScale > tableLayoutScrollView.minimumZoomScale) {
            tableLayoutScrollView.setZoomScale(tableLayoutScrollView.minimumZoomScale, animated: true)
        } else {
            tableLayoutScrollView.setZoomScale(tableLayoutScrollView.maximumZoomScale, animated: true)
        }
    }
    
    

  }

















