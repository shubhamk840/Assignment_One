//
//  main.swift
//  Assignment-2
//
//  Created by Shubham on 20/01/22.
//

import Foundation

var dictionaryOfUsers = [Int : User]() // [rollNumber] = [Users]

protocol Operations{
    func addUser()->User?
    func sortAndDisplay()
    func displayUser(userList: Array<(key: Int, value: User)>)
    func deleteUser(rollNumber : Int)
}


let validator = Validator()
let helper = Helper()

func driver(){
    var flag = 1
    while(flag == 1 ){
        print("1. Add User Details")
        print("2. Display User Details")
        print("3 .Delete User Details")
        print("4 .Exit")
        let choice = readLine()
        switch choice{
        case "1" :
            if let currentUser = helper.addUser(){ // this returns an object that contains all the user data.
                dictionaryOfUsers[currentUser.rollNumber] = currentUser
            }
        case "2" :
            helper.sortAndDisplay()
        case "3" :
            print("Enter the roll number you wish to delete")
            var temp:String?
            var rollNumber:Int?
            repeat{
                print("Enter you roll number")
                temp = readLine()
                rollNumber = Int(temp!)
            }while(!validator.isInt(value: temp))
            if let tempRollNumber = rollNumber{
                helper.deleteUser(rollNumber: tempRollNumber)
            }
        case "4" :
            flag=0;
            print("Thanks for using the program")
        default :
            print("wrong choice entered please re enter")
        }
    }
}



// starting point

driver()
