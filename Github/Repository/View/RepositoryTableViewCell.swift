//
//  RepositoryTableViewCell.swift
//  Github
//
//  Created by baixinpan on 16/5/4.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var owner: UILabel!
    
    var userDetail: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(model: ReposModel) {
        if userDetail {
            owner.text = model.language
        } else {
            avatar.kf_setImageWithURL(NSURL(string: model.owner!.avatar_url!)!)
            owner.text = "Owner: \(model.owner!.login!)"
        }
        name.text = model.name
        start.text = "Stars: \(model.stargazers_count!)"
        desc.text = model.desc
    }

}
