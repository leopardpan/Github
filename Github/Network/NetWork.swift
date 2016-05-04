//
//  NetWork.swift
//  Github
//
//  Created by baixinpan on 16/5/4.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import Foundation
import Alamofire

class Request: AnyObject {
    
    
    static let baseURL = "https://api.github.com"
    
    class func Get(url: String, parameters: [String: AnyObject]? = nil, callBack: (data: AnyObject?) -> Void) {
        
        Alamofire.request(.GET, url, parameters: parameters).responseString { response in
            do {
                let data = try NSJSONSerialization.JSONObjectWithData(response.data!, options: [])
                callBack(data: data)
            } catch {
                
            }
        }
    }
    
    class func SearchUser(page: Int, q: String, sort: String, callBack: (data: AnyObject?) -> Void)  {
        let url: String = "\(baseURL)/search/users?q=\(q)&sort=\(sort)&page=\(page)"
        print(url)
        self.Get(url) { (data) in
            callBack(data: data)
        }
    }
    
    class func SearchRepositories(page: Int, q: String, sort: String, callBack: (data: AnyObject?) -> Void)  {
        let url: String = "\(baseURL)/search/repositories?q=\(q)&sort=\(sort)&page=\(page)"
        print(url)
        self.Get(url) { (data) in
            callBack(data: data)
        }
    }
    
    
    
}

