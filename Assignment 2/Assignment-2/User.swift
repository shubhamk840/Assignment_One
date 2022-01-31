//
//  User.swift
//  Assignment-2
//
//  Created by Shubham on 25/01/22.
//

import Foundation

// This class contains all the properties of the users.


class User {
    var name:String
    var age:Int
    var address:String
    var rollNumber:Int
    var courseList:String
    
    init(name:String,address:String,rollNumber:Int,age:Int,courseList:String){
        self.name = name
        self.address = address
        self.rollNumber = rollNumber
        self.age = age
        self.courseList = courseList
    }
}


