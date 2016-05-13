//
//  UIView+Animation.swift
//  Github
//
//  Created by baixinpan on 16/5/13.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit
import pop

extension UIView {

    func scaleDownView() {
        let scaleAnimation = POPSpringAnimation.init(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation.toValue = NSValue.init(CGPoint: CGPointMake(0.5, 0.5))
        scaleAnimation.springBounciness = 10
        self.layer.pop_addAnimation(scaleAnimation, forKey: "scaleAnimation")
    }

}
