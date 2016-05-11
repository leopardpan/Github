//
//  String+Utils.swift
//  Github
//
//  Created by baixinpan on 16/5/11.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

extension String {

    func transformPinying() -> String? {
        
        let arr = self.componentsSeparatedByString("市")
        let mutableString = NSMutableString(string: arr.first!) as CFMutableStringRef
        if CFStringTransform(mutableString, nil, kCFStringTransformMandarinLatin, false) {
            if CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false) {
                
                let arr = String(mutableString).componentsSeparatedByString(" ")
                var newStr = String()
                for item in arr {
                    newStr += item
                }
                return newStr
            }
        }
        return nil
    }
}
