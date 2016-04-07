//
//  Animator.swift
//  UAP
//
//  Created by Adrian Bolinger on 4/6/16.
//  Copyright © 2016 NoVA. All rights reserved.
//

import UIKit

/*
 This is a generic class created to handle animations for UI elements. I threw in UIView in case we want to animate views later. For now, it's for animating segmented controls, buttons, etc.
 */

class Animator: NSObject {
    var view: UIView?
    var control: UIControl? // Can accept everything that's a subclass of UIControl
    
    override init() {
        super.init()
    }
    
    // FIXME: figure out how to add a completion block as a parameter on a method call
    func animateControl(control: UIControl) {
        control.transform = CGAffineTransformMakeScale(0.75, 0.75)
        UIView.animateWithDuration(0.5,
                                   delay: 0,
                                   usingSpringWithDamping: 0.3,
                                   initialSpringVelocity: 5.0,
                                   options: UIViewAnimationOptions.AllowUserInteraction,
                                   animations: {
                                    control.transform = CGAffineTransformIdentity
        }) { (value: Bool) -> Void in
            // completion block
            // in this instance, the animation is UI candy
        }
    }
}
