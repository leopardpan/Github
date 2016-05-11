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
    private var location: String?
    
    private var searchModel: SearchModel? = SearchModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgViewWidth.constant = self.view.bounds.size.width*3
        loadData()
        requestLocation()
    }
    
    dynamic func loadData() {
        if let model = Archive.fetch("user.data") {
            searchModel = model as? SearchModel
            self.tableView.reloadData()
        }
        requestSearchUser()
    }
    
    dynamic func requestSearchUser() {
        
        let loca = (location != nil) ? location : "beijing"
        let q = "location"+loca!
        let sort = "followers"
        
        request(URLRouter.SearchUser(page: 1, q: q, sort: sort)).responseJSON { (response) in
            do {
                let data = try NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                self.searchModel = SearchModel.mj_objectWithKeyValues(data)
                Archive.save(self.searchModel!, fileName: "user.data")
                self.tableView.reloadData()
            } catch {
                
            }
        }
    }
    
    dynamic func requestLocation () {
        print("requestLocation")

        self.locationManager = CLLocationManager()
        self.locationManager!.delegate = self
        if self.locationManager!.respondsToSelector(#selector(CLLocationManager.requestAlwaysAuthorization)) {
            print("requestAlwaysAuthorization")
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
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    //MARK: CoreLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("get location")
        let location:CLLocation = locations[locations.count-1] as CLLocation
        
        if (location.horizontalAccuracy > 0) {
            self.locationManager!.stopUpdatingLocation()
            print(location.coordinate)
        }
        let geoCoder = CLGeocoder()
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) in
            if placemarks!.count > 0 {
                let city = placemarks!.first!.locality
                let country = placemarks!.first!.country
                
                print(city!.transformPinying())
                print(country!.transformPinying())
                if (city != nil) && city != "beijing" {
                    self.requestSearchUser()
                }
            }
        })
    }    
    
    @IBAction func enterCity(sender: UIBarButtonItem) {
        let cityVC = Storyboards.HomePage.instantiateViewControllerWithIdentifier("cityVC")
        self.navigationController?.pushViewController(cityVC, animated: true)
    }
    
    @IBAction func enterLanguage(sender: UIBarButtonItem) {
        let languageVC = Storyboards.HomePage.instantiateViewControllerWithIdentifier("languageVC")
        self.navigationController?.pushViewController(languageVC, animated: true)
    }
    
}
