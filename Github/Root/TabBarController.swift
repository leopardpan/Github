//
//  TabBarController.swift
//  Github
//
//  Created by 潘柏信 on 16/5/3.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import Foundation

class TabBarController: RDVTabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.setupViewControllers()
        self.customizeInterface()
    }
    
    func setupViewControllers() -> Void {
        let navHome = Storyboards.HomePage.instantiateViewControllerWithIdentifier("navHome")
        navHome.title = "User"
        
        let navRepository = Storyboards.Repository.instantiateViewControllerWithIdentifier("navRepository")
        navRepository.title = "Repository"
        
        let navMine = Storyboards.Mine.instantiateViewControllerWithIdentifier("navMine")
        navMine.title = "Mine"
        
        self.viewControllers = [navHome,navRepository,navMine]
        self.customizeTabBarForController(self)
    }
    
    func customizeTabBarForController(tabBarController:TabBarController) -> Void {
        
        let tabbg_select = UIImage(named: "tabbar_selected_background")
        let tabbg_normal = UIImage(named: "tabbar_normal_background")
        
        let tabBarItemImgs:Array<String> = ["Tab_homepage","Tab_repository","Tab_me"]
        
        var index: Int = 0
        
        for obj in tabBarController.tabBar.items {
            if let item = obj as? RDVTabBarItem {
                let selectImg = UIImage(named: "\(tabBarItemImgs[index])"+"_selected")
                let normalImg = UIImage(named: "\(tabBarItemImgs[index])"+"_normal")
                item.setFinishedSelectedImage(selectImg, withFinishedUnselectedImage: normalImg)
                item.setBackgroundSelectedImage(tabbg_select, withUnselectedImage: tabbg_normal)

                index += 1;
            }
        }
    }
    
    func customizeInterface() -> Void {
        let backgroundImage = UIImage(named: "navigationbar_background_tall")
        UINavigationBar.appearance().setBackgroundImage(backgroundImage, forBarMetrics: UIBarMetrics.Default)

        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(rgb: 0x6d7e8c)], forState: UIControlState.Normal)
    }
    
}
