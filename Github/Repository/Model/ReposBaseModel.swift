//
//  RepositoryBaseModel.swift
//  Github
//
//  Created by baixinpan on 16/5/4.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

class ReposBaseModel: BaseModel {

    var total_count: NSString?
    var incomplete_results: NSNumber?
    var items: [ReposModel]? = []
    
    override static func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        return ["items": ReposModel.classForCoder()]
    }
}
