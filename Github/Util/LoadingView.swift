//
//  LoadingView.swift
//  Github
//
//  Created by baixinpan on 16/5/12.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    @IBOutlet weak var loadingImg: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    static let viewTag = 99999
    
    class func show(inView: UIView) {
        show(nil, inView: inView)
    }
    
    class func show(text: String?, inView: UIView) {
        let pos = CGPointMake(CGRectGetWidth(inView.frame) / 2, CGRectGetHeight(inView.frame) / 2)
        dispatch_async(dispatch_get_main_queue()) { [weak inView] in
            if let old = inView?.viewWithTag(LoadingView.viewTag) as? LoadingView {
                old.removeFromSuperview()
            }
            
            let loading = NSBundle.mainBundle().loadNibNamed("LoadingView", owner: inView, options: nil)[0] as! LoadingView
            loading.tag = LoadingView.viewTag
            if let t = text {
                loading.textLabel.text = t
            }
            loading.layoutIfNeeded()
            loading.center = pos
            loading.startAnimate()
            inView?.addSubview(loading)
            loading.alpha = 0
            UIView.animateWithDuration(0.1, animations: { loading.alpha = 1 }
            )
        }
    }
    
    class func dismiss(inView: UIView?) {
        if let inView = inView {
            dispatch_async(dispatch_get_main_queue()) { [weak inView] in
                if let loading = inView?.viewWithTag(LoadingView.viewTag) as? LoadingView {
                    UIView.animateWithDuration(0.2, animations: { loading.alpha = 0 },
                                               completion: { (_) in
                                                loading.removeFromSuperview()
                        }
                    )
                }
            }
        }
    }
    
    private func startAnimate() {
        loadingImg.layer.removeAllAnimations()
        let anim = CABasicAnimation(keyPath: "transform.rotation.z")
        anim.duration = 0.6
        anim.toValue = M_PI * 2
        anim.cumulative = true
        anim.repeatCount = Float.infinity
        loadingImg.layer.addAnimation(anim, forKey: "spin")
    }
}
