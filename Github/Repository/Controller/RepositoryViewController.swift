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
    
    private var language: String = "Objective-C"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(RepositoryViewController.selectLanguage(_:)), name: "SELECT_LANGUAGE_Repos", object: nil)
        
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
        
        if let model = Archive.fetch("reposit\(language).data") {
            reposit = model as? ReposBaseModel
            self.tableView.reloadData()
        } else {
            LoadingView.show(self.view)
            SearchRepos()
        }
    }
    
    dynamic func SearchRepos() {
        
        let q = "language:\(language)"
        let sort = "stars"
        
        request(URLRouter.SearchRepos(page: 1, q: q, sort: sort)).responseJSON { (response) in
            do {
                LoadingView.dismiss(self.view)
                
                if response.result.error != nil {
                    ToastView.show("请求失败", inView: self.view)
                    return
                }
                
                let data = try NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                
                if let model = ReposBaseModel.mj_objectWithKeyValues(data) {
                    self.reposit = model
                    Archive.save(self.reposit!, fileName: "reposit\(self.language).data")
                    self.tableView.reloadData()
                }
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
    
    
    dynamic func selectLanguage(noti: NSNotification) {
        if let str = noti.object! as? String {
            if self.language != str {
                
                LoadingView.show(self.view)
                self.language = str
                self.SearchRepos()
            }
        }
    }
    
    
    @IBAction func enterLanguage(sender: UIBarButtonItem) {
        let languageVC = Storyboards.HomePage.instantiateViewControllerWithIdentifier("languageVC") as! LanguageViewController
        languageVC.type = .Repos
        self.navigationController?.pushViewController(languageVC, animated: true)
        TalkingData.trackEvent("language")
    }
}
