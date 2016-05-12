//
//  Refresh.swift
//  Github
//
//  Created by baixinpan on 16/5/12.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

class RefreshHeader: MJRefreshGifHeader {

    override func prepare() {
        super.prepare()
        
        var idleImages: [UIImage] = []
        for i in 1...60 {
            let image = UIImage(named: "dropdown_anim__000\(i)")
            idleImages.append(image!)
        }
        self.setImages(idleImages, forState: .Idle)
        
        var refreshingImages: [UIImage] = []
        for i in 1...3 {
            let image = UIImage(named: "dropdown_loading_0\(i)")
            refreshingImages.append(image!)
        }
        self.setImages(refreshingImages, forState: .Pulling)

        self.setImages(refreshingImages, forState: .Refreshing)

    }
}

class RefreshFooter: MJRefreshAutoGifFooter {
    
    override func prepare() {
        super.prepare()

        var refreshingImages: [UIImage] = []
        for i in 1...3 {
            let image = UIImage(named: "dropdown_loading_0\(i)")
            refreshingImages.append(image!)
        }        
        self.setImages(refreshingImages, forState: .Refreshing)
        
    }
}
