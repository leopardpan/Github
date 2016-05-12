//
//  HomePageViewController.swift
//  Github
//
//  Created by 潘柏信 on 16/5/3.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import Alamofire
import CoreLocation

class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var bgViewWidth: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    private var locationManager: CLLocationManager?
    private var city: String?
    
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    private var searchModel: SearchModel? = SearchModel()
    private var page: Int = 1
    private var isPull: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadData()
        requestLocation()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        TalkingData.trackPageBegin("homePage")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        TalkingData.trackPageEnd("homePage")
    }
    
    dynamic func setup() {
        
        bgViewWidth.constant = self.view.bounds.size.width*3

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomePageViewController.selectCity(_:)), name: "SELECT_CITY", object: nil)
        
        self.tableView.mj_header = RefreshHeader(refreshingTarget: self, refreshingAction: #selector(HomePageViewController.tableHeaderRefresh))
        self.tableView.mj_footer = RefreshFooter(refreshingTarget: self, refreshingAction: #selector(HomePageViewController.tableFooterRefresh))
    }
    
    dynamic func loadData() {
        if let model = Archive.fetch("user.data") {
            searchModel = model as? SearchModel
            self.tableView.reloadData()
        } else {
            LoadingView.show(self.view)        
        }
        requestSearchUser()
    }
    
    dynamic func tableHeaderRefresh() {
        page = 1
        isPull = true
        requestSearchUser()
    }
    
    dynamic func tableFooterRefresh() {
        page += 1
        isPull = false
        requestSearchUser()
    }
    
    dynamic func requestSearchUser() {
        
        let newCity = (city != nil) ? city : "beijing"
        let q = "location:"+newCity!
        let sort = "followers"
        
        request(URLRouter.SearchUser(page: page, q: q, sort: sort)).responseJSON { (response) in
            do {
                self.cityLabel.text = newCity
                let data = try NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                let model = SearchModel.mj_objectWithKeyValues(data)
                if model.items!.count != 0 {
                    if self.isPull {
                        self.searchModel = model
                    } else {
                        for user in model.items! {
                            self.searchModel?.items?.append(user)
                        }
                    }
                    Archive.save(self.searchModel!, fileName: "user.data")
                    self.tableView.reloadData()
                }
                LoadingView.dismiss(self.view)
                self.tableView.mj_header.endRefreshing()
                self.tableView.mj_footer.endRefreshing()
            } catch {
                
            }
        }
    }
    
    dynamic func requestLocation () {
        self.locationManager = CLLocationManager()
        self.locationManager!.delegate = self
        if self.locationManager!.respondsToSelector(#selector(CLLocationManager.requestAlwaysAuthorization)) {
            self.locationManager!.requestAlwaysAuthorization()
        }
        self.locationManager?.startUpdatingLocation()
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchModel!.items!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var ID = ""
        switch tableView.tag {
            case 1:
                ID = "cell1"
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
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let userDetail = Storyboards.HomePage.instantiateViewControllerWithIdentifier("userDetail") as! UserDetailViewController
        userDetail.userModel = searchModel!.items![indexPath.row]
        self.navigationController?.pushViewController(userDetail, animated: true)
        
        TalkingData.trackEvent("homePage-cell", label: userDetail.userModel?.login, parameters: ["rank" : indexPath.row])

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    //MARK: CoreLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location:CLLocation = locations[locations.count-1] as CLLocation
        
        if (location.horizontalAccuracy > 0) {
            self.locationManager!.stopUpdatingLocation()
        }
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) in
            if placemarks!.count > 0 {
                let newCity = placemarks!.first!.locality
//                let country = placemarks!.first!.country
                
                if (newCity!.transformPinying() != nil) && newCity!.transformPinying() != "beijing" {
                    self.city = newCity!.transformPinying()
                    self.cityLabel.text = self.city                    
                    self.requestSearchUser()
                }
            }
        })
    }
    
    // MARK: NSNotification
    func selectCity(noti: NSNotification) {
        self.city = noti.object! as? String
        self.requestSearchUser()
    }
    
    @IBAction func enterCity(sender: UIBarButtonItem) {
        let countryVC = Storyboards.HomePage.instantiateViewControllerWithIdentifier("countryVC")
        self.navigationController?.pushViewController(countryVC, animated: true)
        TalkingData.trackEvent("countryVC")
    }
    
    @IBAction func enterLanguage(sender: UIBarButtonItem) {
        let languageVC = Storyboards.HomePage.instantiateViewControllerWithIdentifier("languageVC")
        self.navigationController?.pushViewController(languageVC, animated: true)
        TalkingData.trackEvent("language")
    }
    
}
