//
//  HomePageViewController.swift
//  Github
//
//  Created by 潘柏信 on 16/5/3.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import Alamofire

class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var bgViewWidth: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var searchModel: SearchModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgViewWidth.constant = self.view.bounds.size.width*3
        loadData()
    }
    
    func loadData() {
        if let model = Archive.fetch("user.data") {
            searchModel = model as? SearchModel
            self.tableView.reloadData()
        }
        requestSearchUser()
    }
    
    func requestSearchUser() {
        request(URLRouter.SearchUser(page: 1, q: "location:beijing", sort: "followers")).responseJSON { (response) in
            do {
                let data = try NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                self.searchModel = SearchModel.mj_objectWithKeyValues(data)
                Archive.save(self.searchModel!, fileName: "user.data")
                self.tableView.reloadData()
            } catch {
                
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = searchModel?.items?.count {
            return count
        }
        return 0
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var ID = "cell1"
        switch tableView.tag {
            case 2:
                ID = "cell2"
            case 3:
                ID = "cell3"
            default: break
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath)
        if let userCell = cell as? UserTableViewCell {
            userCell.setupUI(searchModel!.items![indexPath.row])
            userCell.score.text = "\(indexPath.row+1)"
        }
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
}
