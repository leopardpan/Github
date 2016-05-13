//
//  UserTableViewCell.swift
//  Github
//
//  Created by baixinpan on 16/5/4.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit
import pop

class UserTableViewCell: BXTableViewCell {
    
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var login: UILabel!

    dynamic func setupUI(model: UserModel) {
        avatar.name(model.avatar_url!)
        login.text = model.login
    }
    
}
