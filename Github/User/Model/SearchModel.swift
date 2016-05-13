//
//  SearchModel.swift
//  Github
//
//  Created by baixinpan on 16/5/4.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

class SearchModel: BaseModel {
    
    var total_count: NSNumber = 0
    var incomplete_results: NSNumber?
    var items: [UserModel]? = []
    
    override static func mj_objectClassInArray() -> [NSObject : AnyObject]! {
        return ["items": UserModel.classForCoder()]
    }
    
}
