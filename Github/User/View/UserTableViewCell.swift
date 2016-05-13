//
//  UserTableViewCell.swift
//  Github
//
//  Created by baixinpan on 16/5/4.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

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

    dynamic func setupUI(model: UserModel) {
        avatar.sd_setImageWithURL(NSURL(string: model.avatar_url!)!, placeholderImage: UIImage(named: "avatar"))
        
        login.text = model.login
    }
    
}
