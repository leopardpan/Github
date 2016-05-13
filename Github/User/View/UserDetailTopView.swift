//
//  UserDetailTopView.swift
//  Github
//
//  Created by baixinpan on 16/5/5.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

class UserDetailTopView: UIView {

    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var blog: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var created_at: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var location: UILabel!

    
    @IBOutlet weak var repoCount: UILabel!
    @IBOutlet weak var f1Count: UILabel!
    @IBOutlet weak var f2Count: UILabel!
    
    @IBOutlet weak var underLine: UIView!
    
    
    dynamic func setupUI(model: UserDetailModel) {
        
        avatar.name(model.avatar_url!)
        
        login.text = model.login
        blog.text = model.blog
        name.text = model.name
        email.text = model.email
        let index = model.created_at!.startIndex.advancedBy(10) //swift 2.0+
        created_at.text = model.created_at?.substringToIndex(index)
        company.text = model.company
        location.text = model.location
        
        repoCount.text = model.public_repos
        f1Count.text = model.following
        f2Count.text = model.followers
    }
    

}
