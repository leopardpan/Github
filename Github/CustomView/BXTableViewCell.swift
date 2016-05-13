//
//  BXTableViewCell.swift
//  Github
//
//  Created by baixinpan on 16/5/13.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit
import pop

class BXTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
    
        if self.highlighted {
            let scaleAnimation = POPBasicAnimation.init(propertyNamed: kPOPViewScaleXY)
            scaleAnimation.duration = 0.1
            scaleAnimation.toValue = NSValue.init(CGPoint: CGPointMake(0.95, 0.95))
            self.contentView.pop_addAnimation(scaleAnimation, forKey: "scaleAnimation")
        } else {
            let scaleAnimation = POPSpringAnimation.init(propertyNamed: kPOPViewScaleXY)
            scaleAnimation.toValue = NSValue.init(CGPoint: CGPointMake(1, 1))
            scaleAnimation.velocity = NSValue.init(CGPoint: CGPointMake(2, 2))
            scaleAnimation.springBounciness = 20
            self.contentView.pop_addAnimation(scaleAnimation, forKey: "scaleAnimation")
        }
    }
    
}
