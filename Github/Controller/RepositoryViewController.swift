//
//  RepositoryViewController.swift
//  Github
//
//  Created by 潘柏信 on 16/5/3.
//  Copyright © 2016年 leopardpan. All rights reserved.
//


class RepositoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var reposit: RepositoryBaseModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Request.SearchRepositories(1, q: "language:JavaScript", sort: "stars") { (data) in
            self.reposit = RepositoryBaseModel.mj_objectWithKeyValues(data)
            print("repository = \(data)")
            self.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = reposit?.items?.count {
            return count
        }
        return 0
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("repoCell", forIndexPath: indexPath) as! RepositoryTableViewCell
        cell.setupUI(reposit!.items![indexPath.row])
        cell.rank.text = "\(indexPath.row+1)"
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
}
