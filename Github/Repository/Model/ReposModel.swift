//
//  RepositoryModel.swift
//  Github
//
//  Created by baixinpan on 16/5/4.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

class ReposModel: BaseModel {

    var id: NSNumber?
    var name: String?
    var full_name: String?
    var owner: ReposOwnerModel?
    var privat: Bool?
    var html_url: String?
    var desc: String?
    var fork: String?
    var url: String?
    var forks_url: String?
    var keys_url: String?
    var collaborators_url: String?
    var teams_url: String?
    var hooks_url: String?
    var issue_events_url: String?
    var events_url: String?
    var assignees_url: String?
    var branches_url: String?
    var tags_url: String?
    var blobs_url: String?
    var git_tags_url: String?
    
    /******* 需要再加 ********/
    
    var language: String?
  
    /******* 需要再加 ********/
    
    var stargazers_count: String?
    
    
    override static func mj_replacedKeyFromPropertyName() -> [NSObject : AnyObject]! {
        return ["desc" : "description"]
    }
}
