//
//  CityViewController.swift
//  Github
//
//  Created by baixinpan on 16/5/11.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

class CityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var citys: [String] = []
    var country: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        return citys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ID = "cityCell"
        let cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath)
        cell!.textLabel?.text = citys[indexPath.row]
        return cell!
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let city = self.citys[indexPath.row]
        
        let dic = ["city":city,"country":country]
        NSNotificationCenter.defaultCenter().postNotificationName("SELECT_CITY", object: dic)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
        
    }

}
