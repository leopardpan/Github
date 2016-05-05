//
//  UserDetailViewController.swift
//  Github
//
//  Created by baixinpan on 16/5/5.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var topViewWidth: NSLayoutConstraint!
    @IBOutlet weak var bottomViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var topView: UserDetailTopView!
    
    @IBOutlet weak var tableViewRepo: UITableView!
    @IBOutlet weak var tableViewFollowing: UITableView!
    @IBOutlet weak var tableVlewFollower: UITableView!
    
    var userModel: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topViewWidth.constant = self.view.bounds.size.width
        bottomViewWidth.constant = self.view.bounds.size.width*3

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return 0
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var ID = "cellRepo"
        switch tableView.tag {
        case 2:
            ID = "celF1"
        case 3:
            ID = "cellF2"
        default: break
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath)
        print("cell = \(cell)")
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }

}
