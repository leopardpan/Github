//
//  BaseModel.swift
//  Github
//
//  Created by baixinpan on 16/5/5.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

class BaseModel: NSObject, NSCoding {

    func encodeWithCoder(aCoder: NSCoder){
        mj_encode(aCoder)
    }
    required init(coder aDecoder: NSCoder) {
        super.init()
        mj_decode(aDecoder)
    }
    override init() {}
}
