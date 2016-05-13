//
//  CountryViewController.swift
//  Github
//
//  Created by baixinpan on 16/5/12.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var datasource = [String: AnyObject]()
    var countrys: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCityData()
        // Do any additional setup after loading the view.
    }
    
    dynamic func loadCityData() {
        
        let path = NSBundle.mainBundle().pathForResource("city", ofType: "json")
        do {
            let str = try String(contentsOfFile: path!)
            let data = str.dataUsingEncoding(NSUTF8StringEncoding)
            let dic = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
            self.datasource = dic as! [String : AnyObject]
            for key in self.datasource {
                self.countrys.append(key.0)
            }
            self.tableView.reloadData()
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
        
        let ID = "countrysCell"
        let cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath)
        cell!.textLabel?.text = countrys[indexPath.row]
        return cell!
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let arr = self.datasource[countrys[indexPath.row]]
        
        let cityVC = Storyboards.HomePage.instantiateViewControllerWithIdentifier("cityVC") as? CityViewController
        cityVC?.citys = arr as! [String]
        cityVC?.country = countrys[indexPath.row]
        self.navigationController?.pushViewController(cityVC!, animated: true)
        TalkingData.trackEvent("cityVC")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
}
