//
//  UserDetailViewController.swift
//  Github
//
//  Created by baixinpan on 16/5/5.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit
import Alamofire

class UserDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var bottomViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var topView: UserDetailTopView!
    
    @IBOutlet weak var scrollerView: UIScrollView!
    
    @IBOutlet weak var tableViewRepo: UITableView!
    @IBOutlet weak var tableViewFollowing: UITableView!
    @IBOutlet weak var tableVlewFollower: UITableView!
    
    
    var userModel: UserModel?
    
    private var userDetailModel: UserDetailModel?

    private var reposModels: [ReposModel]? = []
    private var reposF1Models: [ReposModel]? = []
    private var reposF2Models: [ReposModel]? = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomViewWidth.constant = self.view.bounds.size.width*3
        self.automaticallyAdjustsScrollViewInsets = false
        loadData()
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
    
    private func loadData() {
        
        if (userModel != nil) {
            self.title = userModel?.login
            
            let fileNameUser = "userDetail\(self.userModel!.login!).data"
            self.userDetailModel = Archive.fetch(fileNameUser) as? UserDetailModel
            if (self.userDetailModel != nil) {
                self.topView.setupUI(self.userDetailModel!)
            }
            requestUserDetail()
            
            let fileNameRepo = "userRepos\(self.userModel!.login!).data"
            let repos = Archive.fetch(fileNameRepo) as? [ReposModel]
            if (repos != nil) {
                self.reposModels = repos
                tableViewRepo.reloadData()
            } else {
                LoadingView.show(self.view)
            }
            requestUserRepos()
        }
    }
    
    private func requestUserDetail() {
        request(URLRouter.UserDetail(name: userModel!.login!)).responseJSON { (response) in
            do {
                
                if response.result.error != nil {
                    return
                }
                
                let data = try NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                self.userDetailModel = UserDetailModel.mj_objectWithKeyValues(data)
                if (self.userDetailModel != nil) {
                    self.topView.setupUI(self.userDetailModel!)
                    let fileName = "userDetail\(self.userModel!.login!).data"
                    Archive.save(self.userDetailModel!, fileName: fileName)
                }
            } catch { }
        }
    }
    
    private func requestUserRepos() {
        request(URLRouter.UserRepos(page: 1, name: userModel!.login!)).responseJSON { (response) in
            do {
                
                LoadingView.dismiss(self.view)
                if response.result.error != nil {
                    ToastView.show("请求失败", inView: self.view)
                    return
                }
                
                let data = try NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                if let arr = data as? [AnyObject] {
                    for obj in arr {
                        let repoModel = ReposModel.mj_objectWithKeyValues(obj)
                        self.reposModels?.append(repoModel)
                    }
                    
                    let fileName = "userRepos\(self.userModel!.login!).data"
                    Archive.save(self.reposModels!, fileName: fileName)
                    
                    self.tableViewRepo.reloadData()
                }
                
            } catch { }
        }
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        switch tableView.tag {
            case 1:
                return reposModels!.count
            case 2:
                return reposF1Models!.count
            case 3:
                return reposF2Models!.count
            default: break
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var ID = ""
        switch tableView.tag {
            case 1:
                ID = "repoCell"
            case 2:
                ID = "cellF1"
            case 3:
                ID = "cellF2"
            default: break
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath) as! RepositoryTableViewCell
        if tableView.tag == 1 {
            cell.userDetail = true
        }
        cell.setupUI(self.reposModels![indexPath.row])
        cell.rank.text = "\(indexPath.row+1)"
  
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x > 0 {
            let index = Int(scrollView.contentOffset.x/self.view.bounds.size.width)
            let scale = self.view.bounds.size.width/3
            let x = (scale-50)/2 + scale*CGFloat(index)
            let rect = CGRectMake(x, 158, 50, 2)
            
            UIView.animateWithDuration(0.5, animations: {
                self.topView.underLine.frame = rect
            })
        }
    }

}
