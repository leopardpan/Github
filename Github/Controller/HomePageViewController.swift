//
//  HomePageViewController.swift
//  Github
//
//  Created by 潘柏信 on 16/5/3.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var bgViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchModel: SearchModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Request.SearchUser(1, q: "location:beijing", sort: "followers") { (data) in
            self.searchModel = SearchModel.mj_objectWithKeyValues(data)
            self.tableView.reloadData()
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath) as! UserTableViewCell
        cell.setupUI(searchModel!.items![indexPath.row])
        cell.score.text = "\(indexPath.row+1)"
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
}
