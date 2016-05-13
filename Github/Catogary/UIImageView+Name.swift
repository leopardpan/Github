//
//  UIImageView+Name.swift
//  Github
//
//  Created by baixinpan on 16/5/13.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit


extension UIImageView {

    func name(url: String!) {
        self.sd_setImageWithURL(NSURL(string: url)!, placeholderImage: UIImage(named: "avatar"))

    }
    
    func name(url: String!, placeholderName: String!) {
        self.sd_setImageWithURL(NSURL(string: url)!, placeholderImage: UIImage(named: placeholderName))
    }
    
}
