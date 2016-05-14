//
//  LanguageViewController.swift
//  Github
//
//  Created by baixinpan on 16/5/11.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

class LanguageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    enum LanguageEntranceType: Int {
        case User = 0,
             Repos = 1
    }
    
    var type: LanguageEntranceType = .User
    
    @IBOutlet weak var tableView: UITableView!
    
    private var languages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        laodData()

        // Do any additional setup after loading the view.
    }
    
    dynamic func laodData() {
        switch type {
        case .User:
            languages = ["all languages","JavaScript","Java","PHP","Ruby","Python","CSS","CPP","C","Objective-C","Swift","Shell","R","Perl","Lua","HTML","Scala","Go"]
        case .Repos:
            languages = ["JavaScript","Java","PHP","Ruby","Python","CSS","CPP","C","Objective-C","Swift","Shell","R","Perl","Lua","HTML","Scala","Go"]
        }
        tableView.reloadData()
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
        return languages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ID = "languageCell"
        let cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath)
        cell!.textLabel?.text = languages[indexPath.row]
        return cell!
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let language = self.languages[indexPath.row]
        
        var name = ""
        
        switch type {
        case .User:
            name = "SELECT_LANGUAGE_User"
        case .Repos:
            name = "SELECT_LANGUAGE_Repos"
        }
        NSNotificationCenter.defaultCenter().postNotificationName(name, object: language)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
        
    }

}
