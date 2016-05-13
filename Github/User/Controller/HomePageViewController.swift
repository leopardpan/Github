//
//  HomePageViewController.swift
//  Github
//
//  Created by 潘柏信 on 16/5/3.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import Alamofire
import CoreLocation

class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var bgViewWidth: NSLayoutConstraint!
    @IBOutlet weak var tableViewCity: UITableView!
    @IBOutlet weak var tableViewCountry: UITableView!
    
    private var locationManager: CLLocationManager?
    private var city: String?
    private var country: String?
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    private var searchModelCity: SearchModel? = SearchModel()
    private var searchModelCountry: SearchModel? = SearchModel()
    
    private var currentPage: Int = 1
    
    private var pageCity = PageModel()
    private var pageCountry = PageModel()
    
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
        
        bgViewWidth.constant = self.view.bounds.size.width*2

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomePageViewController.selectCity(_:)), name: "SELECT_CITY", object: nil)
        
        self.tableViewCity.mj_header = RefreshHeader(refreshingTarget: self, refreshingAction: #selector(HomePageViewController.tableHeaderRefresh))
        self.tableViewCity.mj_footer = RefreshFooter(refreshingTarget: self, refreshingAction: #selector(HomePageViewController.tableFooterRefresh))
        self.tableViewCountry.mj_header = RefreshHeader(refreshingTarget: self, refreshingAction: #selector(HomePageViewController.tableHeaderRefresh))
        self.tableViewCountry.mj_footer = RefreshFooter(refreshingTarget: self, refreshingAction: #selector(HomePageViewController.tableFooterRefresh))
    }
    
    dynamic func loadData() {
        
       let object = NSUserDefaults.standardUserDefaults().objectForKey("location")
        
        if let dic = object as? [String:String] {
            self.city = dic["city"]
            self.country = dic["country"]
        } else {
            self.city = "beijing"
            self.country = "china"
        }
        self.cityLabel.text = self.city
        self.countryLabel.text = self.country
        
        if let model = Archive.fetch("userCity:\(self.city).data") {
            searchModelCity = model as? SearchModel
            self.tableViewCity.reloadData()
        } else {
            LoadingView.show(self.view)        
        }
        
        if let model = Archive.fetch("userCountry:\(self.country).data") {
            searchModelCountry = model as? SearchModel
        } else {
            LoadingView.show(self.view)
        }
        
        requestSearchUser()
    }
    
    dynamic func tableHeaderRefresh() {

        if self.currentPage == 1 {
            pageCity.page = 1
            pageCity.isPullUp = true
        } else if self.currentPage == 2 {
            pageCountry.page = 1
            pageCountry.isPullUp = true
        }
        requestSearchUser()
    }
    
    dynamic func tableFooterRefresh() {
        
        if self.currentPage == 1 {
            pageCity.page += 1
            pageCity.isPullUp = false
        } else if self.currentPage == 2 {
            pageCountry.page += 1
            pageCountry.isPullUp = false
        }
        requestSearchUser()
    }
    
    dynamic func requestSearchUser() {
        
        var page = 1
        var location = ""
        if currentPage == 1 {
            
            page = pageCity.page
            location = (city != nil) ? city! : "beijing"
            self.cityLabel.text = location
        } else if currentPage == 2 {
            
            page = pageCountry.page
            location = (country != nil) ? country! : "china"
            self.countryLabel.text = location
        }
        
        let q = "location:"+location
        let sort = "followers"

        request(URLRouter.SearchUser(page: page, q: q, sort: sort)).responseJSON { (response) in
            do {
                let data = try NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                let model = SearchModel.mj_objectWithKeyValues(data)
                if model.items!.count != 0 {
                    
                    if self.currentPage == 1 {
                        if self.pageCity.isPullUp {
                            self.searchModelCity = model
                            self.tableViewCity.mj_header.endRefreshing()
                            LoadingView.dismiss(self.view)
                        } else {
                            for user in model.items! {
                                self.searchModelCity?.items?.append(user)
                            }
                            self.tableViewCity.mj_footer.endRefreshing()
                        }
                        Archive.save(self.searchModelCity!, fileName: "userCity:\(self.city).data")
                        self.tableViewCity.reloadData()
                    } else if self.currentPage == 2 {
                        if self.pageCountry.isPullUp {
                            self.searchModelCountry = model
                            self.tableViewCountry.mj_header.endRefreshing()
                        } else {
                            for user in model.items! {
                                self.searchModelCountry?.items?.append(user)
                            }
                            self.tableViewCountry.mj_footer.endRefreshing()
                        }
                        Archive.save(self.searchModelCountry!, fileName: "userCountry:\(self.country).data")
                        self.tableViewCountry.reloadData()
                    }
                }
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
        
        if self.currentPage == 1 {
            return searchModelCity!.items!.count
        } else if self.currentPage == 2 {
            print(searchModelCountry!.items!.count)
            return searchModelCountry!.items!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var ID = ""
        if tableView.tag == 1 {
            ID = "cell1"
        } else if tableView.tag == 2 {
            ID = "cell2"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath)
        if tableView == self.tableViewCity {
            if let userCell = cell as? UserTableViewCell {
                userCell.setupUI(searchModelCity!.items![indexPath.row])
                userCell.rank.text = "\(indexPath.row+1)"
            }
        } else if tableView == tableViewCountry {
            if let userCell = cell as? UserTableViewCell {
                userCell.setupUI(searchModelCountry!.items![indexPath.row])
                userCell.rank.text = "\(indexPath.row+1)"
            }
        }
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let userDetail = Storyboards.HomePage.instantiateViewControllerWithIdentifier("userDetail") as! UserDetailViewController
        userDetail.userModel = searchModelCity!.items![indexPath.row]
        self.navigationController?.pushViewController(userDetail, animated: true)
        
        let label = "Device:\(UIDevice.currentDevice().name), Rank:\(userDetail.userModel!.login!)"
        TalkingData.trackEvent("homePage-cell", label: label , parameters: ["rank" : indexPath.row])

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x > 0 {
            let index = lroundf(Float(scrollView.contentOffset.x/self.view.bounds.size.width))+1
            if currentPage != index {
                currentPage = index
                self.setLabel()
                
                if currentPage == 2 {
                    if searchModelCountry?.items?.count == 0 {
                        LoadingView.show(self.view)                        
                        self.requestSearchUser()
                    }
                }
            }
        }
    }
    
    dynamic func setLabel() {
        if currentPage == 1 {
            cityLabel.font = UIFont.boldSystemFontOfSize(12)
            cityLabel.textColor = UIColor.blackColor()
            countryLabel.font = UIFont.systemFontOfSize(12)
            countryLabel.textColor = UIColor.grayColor()
        } else if currentPage == 2 {
            cityLabel.font = UIFont.systemFontOfSize(12)
            cityLabel.textColor = UIColor.grayColor()
            countryLabel.font = UIFont.boldSystemFontOfSize(12)
            countryLabel.textColor = UIColor.blackColor()
        }
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
        
        if let dic = noti.object! as? [String:String] {
            self.city = dic["city"]
            self.country = dic["country"]
            
            self.cityLabel.text = dic["city"]
            self.countryLabel.text = dic["country"]
            
            NSUserDefaults.standardUserDefaults().setObject(dic, forKey: "location")
            
            currentPage = 1
            self.requestSearchUser()
        }
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
