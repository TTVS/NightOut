//
//  SlideSegueFromRight.swift
//  Clubber
//
//  Created by Terra on 9/8/15.
//  Copyright (c) 2015 Dino Media Asia. All rights reserved.
//

import UIKit


class UIStoryboardSegueFromRight: UIStoryboardSegue {
    
    override func perform()
    {
        let src = self.sourceViewController 
        let dst = self.destinationViewController 
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransformMakeTranslation(src.view.frame.size.width, 0)
        
        UIView.animateWithDuration(0.25,
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                dst.view.transform = CGAffineTransformMakeTranslation(0, 0)
            },
            completion: { finished in
                src.presentViewController(dst, animated: false, completion: nil)
            }
        )
    }
}

class UIStoryboardUnwindSegueFromRight: UIStoryboardSegue {
    
    override func perform()
    {
        let src = self.sourceViewController 
        let dst = self.destinationViewController 
        
        src.view.superview?.insertSubview(dst.view, belowSubview: src.view)
        src.view.transform = CGAffineTransformMakeTranslation(0, 0)
        
        UIView.animateWithDuration(0.25,
            delay: 0.0,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                src.view.transform = CGAffineTransformMakeTranslation(src.view.frame.size.width, 0)
            },
            completion: { finished in
                src.dismissViewControllerAnimated(false, completion: nil)
            }
        )
    }
}