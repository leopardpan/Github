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
        self.setupNavgationBar()
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
                
        let tabBarItemImgs:Array<String> = ["Tab_hp","Tab_repo","Tab_me"]
        
        var index: Int = 0
        
        for obj in tabBarController.tabBar.items {
            if let item = obj as? RDVTabBarItem {
                let selectImg = UIImage(named: "\(tabBarItemImgs[index])"+"_selected")
                let normalImg = UIImage(named: "\(tabBarItemImgs[index])"+"_normal")
                item.setFinishedSelectedImage(selectImg, withFinishedUnselectedImage: normalImg)
                index += 1;
            }
        }
    }
    
    func setupNavgationBar() -> Void {
        let backgroundImage = UIImage(named: "nav_bg")
        UINavigationBar.appearance().setBackgroundImage(backgroundImage, forBarMetrics: UIBarMetrics.Default)
    
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "Nav_Back")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "Nav_Back")
        UINavigationBar.appearance().shadowImage = UIImage()
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
 
    }
    

}

extension TabBarController {

    class func hiddenTabBar() {
        
        let delegate =  UIApplication.sharedApplication().delegate as! AppDelegate
        let tabBarVC = delegate.window?.rootViewController as? TabBarController
        tabBarVC?.tabBarHidden = true
    }
    
    class func showTabBar() {
        
        let delegate =  UIApplication.sharedApplication().delegate as! AppDelegate
        let tabBarVC = delegate.window?.rootViewController as? TabBarController
        tabBarVC?.tabBarHidden = false
    }

}
