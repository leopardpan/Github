//
//  CityViewController.swift
//  Github
//
//  Created by baixinpan on 16/5/11.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

class CityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    let countrys = [String: AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    dynamic func loadCityData() {
        
        let path = NSBundle.mainBundle().pathForResource("city", ofType: "json")
        do {
            let str = try String(contentsOfFile: path!)
            let data = try NSJSONSerialization.dataWithJSONObject(str, options: [])

        } catch {}
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        TabBarController.hiddenTabBar()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        TabBarController.showTabBar()
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countrys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ID = "cityCell"
        let cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath)
//        cell!.textLabel?.text = countrys.allkey[indexPath.row]
        return cell!
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

}
