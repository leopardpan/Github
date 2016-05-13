//
//  Utils.swift
//  Github
//
//  Created by baixinpan on 16/5/13.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

class Utils: NSObject {

}


/*! Handy func to call GCD_After.  */
func delayBySeconds(seconds: Double, delayedCode: ()->()) {
    let targetTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * seconds))
    dispatch_after(targetTime, dispatch_get_main_queue()) {
        delayedCode()
    }
}

extension UIImage {
    func scaleToSize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        drawInRect(CGRectMake(0, 0, size.width, size.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
}