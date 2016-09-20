//
//  CircularImagePickerOverlay.swift
//  Clubber
//
//  Created by Terra on 14/10/2015.
//  Copyright © 2015 Dino Media Asia. All rights reserved.
//

import UIKit

class CircularImagePickerOverlay: UIView {

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        self.opaque = false
//        self.backgroundColor = UIColor.clearColor()
//        let crosshair: UIImage = UIImage(named:"crosshair")!
//        let crosshairView: UIImageView = UIImageView(image: crosshair)
//        crosshairView.frame = CGRectMake(0, 40, 320, 300)
//        crosshairView.contentMode = UIViewContentMode.Center
//        self.addSubview(crosshairView)
//        
////        crosshairView.release()
//        
//        
//        let button = UIButton(type: UIButtonType.RoundedRect)
//        button.setTitle("Catch now", forState: UIControlState.Normal)
//        button.frame = CGRectMake(0, 430, 320, 40)
//        self.addSubview(button)
//        
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    deinit {
//        // perform the deinitialization
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        backgroundColor = UIColor.clearColor()
        userInteractionEnabled = true
        
        let button = UIButton(type: UIButtonType.RoundedRect)
        button.setTitle("Catch now", forState: UIControlState.Normal)
        button.frame = CGRectMake(0, 430, 320, 40)
        self.addSubview(button)
        

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        // draws lines and curves to make shapes
        let path = UIBezierPath()
        
        let topCrosshair = CGPoint(x: center.x, y: center.y + 10.0)
        let rightCrosshair = CGPoint(x: center.x + 10.0, y: center.y)
        let bottomCrosshair = CGPoint(x: center.x, y: center.y - 10.0)
        let leftCrosshair = CGPoint(x: center.x - 10.0, y: center.y)
        
        // "pick up" the path and move it to the correct point, then draw across
        path.moveToPoint(topCrosshair)
        path.addLineToPoint(bottomCrosshair)
        path.moveToPoint(leftCrosshair)
        path.addLineToPoint(rightCrosshair)
        
        
        path.lineWidth = 1.0
        
        // Close to the yellow used in the Camera app
        UIColor(red: 255.0, green: 204.0, blue: 0.0, alpha: 1.0).setStroke()
        
        path.stroke()
    }

}
