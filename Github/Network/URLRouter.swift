//
//  URLRouter.swift
//  Github
//
//  Created by baixinpan on 16/5/5.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit
import Alamofire

public enum Method: String {
    case OPTIONS, GET, HEAD, POST, PUT, PATCH, DELETE, TRACE, CONNECT
}

enum URLRouter: URLRequestConvertible {
    
    case SearchUser(page: Int, q: String, sort: String)
    case UserDetail(name: String)
    
    case UserRepos(page: Int, name: String)
    case UserFollowing(page: Int, name: String)
    case UserFollowers(page: Int, name: String)

    case SearchRepositories(page: Int, q: String, sort: String)
    
    var URLRequest: NSMutableURLRequest {
        
        var path: String!
        var params: [String: AnyObject]?
        var method: Method?
        
        switch self {
            case .SearchUser(let page, let q, let sort):
                method = .GET
                path = "search/users?q=\(q)&sort=\(sort)&page=\(page)"
            case .UserDetail(let name):
                method = .GET
                path = "users/\(name)"
            case .UserRepos(let page, let name):
                method = .GET
                path = "users/\(name)/repos?sort=updated&page=\(page)"
            case .UserFollowers(let page, let name):
                method = .GET
                path = "users/\(name)/followers?page=\(page)"
            case .UserFollowing(let page, let name):
                method = .GET
                path = "users/\(name)/following?page=\(page)"
            case .SearchRepositories(let page, let q, let sort):
                method = .GET
                path = "search/repositories?q=\(q)&sort=\(sort)&page=\(page)"
        }
        
        let baseURL = "https://api.github.com/"
        
        let request = NSMutableURLRequest()
        request.URL = NSURL(string: "\(baseURL)\(path)")
        print(request.URL);
        request.HTTPMethod = method!.rawValue
        return ParameterEncoding.URL.encode(request, parameters: params).0
    }
}
