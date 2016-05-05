//
//  NSObject+Archive.swift
//  Github
//
//  Created by baixinpan on 16/5/5.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

class Archive {

    static let filePathRoot = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]

    class func save(model: NSObject, fileName: String){
        let filePath = filePathRoot+"/"+fileName
        NSKeyedArchiver.archiveRootObject(model, toFile: filePath)
    }
    
    class func fetch(fileName: String) -> AnyObject? {
        
        let filePath = filePathRoot+"/"+fileName
        return NSKeyedUnarchiver.unarchiveObjectWithFile(filePath)
    }
    
}
