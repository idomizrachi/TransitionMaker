//
//  CrossfadeUpwardTransitionPresent.swift
//  Pods
//
//  Created by Matan Cohen on 9/4/16.
//
//

import Foundation
import UIKit

class CrossfadeUpwardTransitionPresent: NSObject {
    static func animateTransitionObject(transitionObject : CrossfadeUpwardTransitionObject, fromViewController : UIViewController, toViewController : UIViewController, containerView : UIView, animationOptions: UIViewAnimationOptions, fadeOutAnimationDelay: NSTimeInterval) {
        
        let upwardOffset: CGFloat = 30
        
        containerView.bringSubviewToFront(transitionObject.viewToAnimateTo)
        
        var finalFrame = toViewController.view!.convertRect(transitionObject.viewToAnimateTo.frame, toView: containerView)
        if let isFrameToAnimateTo = transitionObject.frameToAnimateTo {
            finalFrame = isFrameToAnimateTo
        }
        
        var startFrame = finalFrame
        startFrame.origin.y += upwardOffset
        
        transitionObject.viewToAnimateTo.setNeedsDisplay()
        transitionObject.viewToAnimateTo.setNeedsLayout()
        
        var viewCopy = transitionObject.viewToAnimateTo.copyView()
        containerView.addSubview(viewCopy)
        viewCopy.frame = startFrame
        
        
        transitionObject.viewToAnimateTo.hidden = true
        viewCopy.alpha = 0

        UIView.animateWithDuration(transitionObject.duration, delay: 0, options: animationOptions, animations: {
            
            viewCopy.frame = finalFrame
            viewCopy.alpha = 1
            }) { (done) in
                transitionObject.viewToAnimateTo.hidden = false
                afterDelay(0.2, completion: {
                    viewCopy.removeFromSuperview()
                })
        }
    }
}