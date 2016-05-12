//
//  RepositoryViewController.swift
//  Github
//
//  Created by 潘柏信 on 16/5/3.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import Alamofire

class RepositoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var reposit: ReposBaseModel? = ReposBaseModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        TalkingData.trackPageBegin("Repository")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        TalkingData.trackPageEnd("Repository")
    }
    
    dynamic func loadData() {
        if let model = Archive.fetch("reposit.data") {
            reposit = model as? ReposBaseModel
            self.tableView.reloadData()
        }
        requestSearchUser()
    }
    
    dynamic func requestSearchUser() {
        request(URLRouter.SearchRepos(page: 1, q: "language:JavaScript", sort: "stars")).responseJSON { (response) in
            do {
                let data = try NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                self.reposit = ReposBaseModel.mj_objectWithKeyValues(data)
                Archive.save(self.reposit!, fileName: "reposit.data")
                self.tableView.reloadData()
            } catch {
                
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposit!.items!.count
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
