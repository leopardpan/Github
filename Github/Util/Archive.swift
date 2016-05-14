//
//  NSObject+Archive.swift
//  Github
//
//  Created by baixinpan on 16/5/5.
//  Copyright © 2016年 leopardpan. All rights reserved.
//

import UIKit
import RealmSwift


class Archive {

    static let filePathRoot = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]

    class func save(model: NSObject, fileName: String){
        let filePath = filePathRoot+"/"+fileName
        NSKeyedArchiver.archiveRootObject(model, toFile: filePath)
    }
    
    class func fetch(fileName: String) -> AnyObject? {
        
        let filePath = filePathRoot+"/"+fileName
        return NSKeyedUnarchiver.unarchiveObjectWithFile(filePath)
    }
    
    
    class func reamlTest() {

        let realm = try! Realm()
        try! realm.write {
            
            // 简单的添加
//            realm.create(Person.self, value: ["person1",[["dog1",1]]])
//             更新，主键name存在则更新， 不存在则添加
            realm.create(Person.self, value: ["person2",[[1,"dog2"]]], update: true)
            
        }
        
        let allDogs = realm.objects(Dog)
        for dog in allDogs {
            let ownerNames = dog.owners.map { $0.name }
            print("\(dog.name) has \(ownerNames.count) owners (\(ownerNames))")
        }
        
        let allperson = realm.objects(Person)
        print("allperson = \(allperson)")
    }
}

class Dog: Object {
    dynamic var name = ""
    dynamic var age = 0
    // 与person的 dogs属性建立关联
    let owners = LinkingObjects(fromType: Person.self, property: "dogs")
}

class Person: Object {
    dynamic var name = ""
    let dogs = List<Dog>()
    
    // 设置主键，update 时必须要
    override class func primaryKey() -> String {
        return "name"
    }
}
