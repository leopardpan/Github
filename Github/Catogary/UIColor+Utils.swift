//
//  UIColor+Utils.swift
//  Github
//
//  Created by 潘柏信 on 16/5/3.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import Foundation
extension UIColor {

    convenience init(rgb: UInt) {
        self.init(red: CGFloat((rgb & 0xff0000) >> 16) / 255.0,
                  green: CGFloat((rgb & 0x00ff00) >> 8) / 255.0,
                  blue: CGFloat(rgb & 0x0000ff) / 255.0,
                  alpha: CGFloat(1))
    }
    
    convenience init(rgb: UInt, alpha: CGFloat) {
        self.init(red: CGFloat((rgb & 0xff0000) >> 16) / 255.0,
                  green: CGFloat((rgb & 0x00ff00) >> 8) / 255.0,
                  blue: CGFloat(rgb & 0x0000ff) / 255.0,
                  alpha: CGFloat(alpha))
    }
}
