//
//  UserTableViewCell.swift
//  Github
//
//  Created by baixinpan on 16/5/4.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {

    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var login: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupUI(model: UserModel) {
        avatar.kf_setImageWithURL(NSURL(string: model.avatar_url!)!)
        login.text = model.login
    }
    
}
