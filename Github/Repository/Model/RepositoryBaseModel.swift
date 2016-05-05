//
//  RepositoryBaseModel.swift
//  Github
//
//  Created by baixinpan on 16/5/4.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

class RepositoryBaseModel: BaseModel {

    var total_count: NSString?
    var incomplete_results: NSNumber?
    var items: [RepositoryModel]?
    
    override static func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        return ["items": RepositoryModel.classForCoder()]
    }
}
