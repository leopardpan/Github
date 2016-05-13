//
//  ToastView.swift
//  Github
//
//  Created by baixinpan on 16/5/13.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

class ToastView: UIView {
    @IBOutlet weak var textLabel: UILabel!
    
    static let viewTag = 99998
    
    class func show(text: String?, inView: UIView?) {
        if let t = text, inView = inView {
            let pos = CGPointMake(CGRectGetWidth(inView.frame) / 2, CGRectGetHeight(inView.frame) / 2)
            dispatch_async(dispatch_get_main_queue()) { [weak inView] in
                if let old = inView?.viewWithTag(ToastView.viewTag) as? ToastView {
                    old.removeFromSuperview()
                }
                
                let toast = NSBundle.mainBundle().loadNibNamed("ToastView", owner: inView, options: nil)[0] as! ToastView
                toast.textLabel!.text = t
                toast.layoutIfNeeded()
                toast.center = pos
                inView?.addSubview(toast)
                toast.alpha = 0
                UIView.animateWithDuration(0.1, animations: { toast.alpha = 1 },
                                           completion: { (_) in
                                            delayBySeconds(2) {
                                                UIView.animateWithDuration(0.2, animations: { toast.alpha = 0 },
                                                    completion: { (_) in
                                                        toast.removeFromSuperview()
                                                    }
                                                )
                                            }
                    }
                )
            }
        }
    }
}
