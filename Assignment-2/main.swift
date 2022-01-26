//
//  main.swift
//  Assignment-2
//
//  Created by Shubham on 20/01/22.
//

import Foundation

var dictionaryOfUsers = [Int : User]() // [rollNumber] = [Users]

func addUser() -> User?{
    var name:String?
    var age:Int?
    var address: String?
    var rollNumber: Int?
    // rollNumber input
    var temp:String?
    var flag = 0
    repeat{
        print("Enter your roll number")
        temp = readLine()
        if let current = temp{
            rollNumber = Int(current)
            if let tempRollNumber = rollNumber{
                if(dictionaryOfUsers[tempRollNumber] != nil){
                    print("This roll number already exits")
                    flag=1
                    continue
                }
            }
        }
    }while(flag == 1 || !isInt(value: temp)) // loops till any of the following are true 1.Roll number already found 2. Entered value is not Int
    
    
    // name input
    repeat{
        print("Enter your full name")
        name = readLine()
        
    }while(!nameValidator(name: name))
    
    // age input part
    repeat{
        print("Enter your age")
        temp = readLine()
        if let current = temp{
            age = Int(current)
        }
    }while(!isInt(value: temp))
    
    // address input part
    print("Address")
    address = readLine()
    
    // roll number input
    
    
    var courses:String = ""
    repeat{
        print("Enter the four out of any 6 subjects A,B,C,D,E,F that you wish to choose")
        if let inputLine = readLine(){
            
            courses = inputLine
            
        }
        else{
            print("Nothing has been entered by you, retry")
        }
        
    }while(!courseValidation(inputLine : courses))
    if let tempName = name, let tempAddress = address, let tempRollNumber = rollNumber, let tempAge = age{
        let currentUser = User(name: tempName, address: tempAddress, rollNumber: tempRollNumber, age: tempAge, courseList: courses)
        return currentUser
    }
    return nil
    
}

func sortAndDisplay(){
    print("Enter the choice of sorting")
    print("1. Based on Name (Ascending)")
    print("2. Based on Name (Descending)")
    print("3. Based on Age (Ascending)")
    print("4. Based on Age (Descending)")
    print("5. Based on Roll Number (Ascending)")
    print("6. Based on Roll Number (Descending)")
    print("7. Based on Address (Descending)")
    print("8. Based on Address (Ascending)")
    if let choice = readLine(){
        if let tempChoice = Int(choice){
            switch tempChoice{
            case 1 , 2:
                let sortedByName = dictionaryOfUsers.sorted{
                    tempChoice%2==0 ? ($0.1.name < $1.1.name) : ($0.1.name > $1.1.name)
                }
                displayUser(userList: sortedByName)
            case 3 , 4:
                let sortedByAge = dictionaryOfUsers.sorted{
                    tempChoice%2==0 ? ($0.1.age < $1.1.age) : ($0.1.age > $1.1.age)
                }
                displayUser(userList: sortedByAge)
            case 5 , 6:
                let sortedByRollNumber = dictionaryOfUsers.sorted{
                    tempChoice%2==0 ? ($0.1.rollNumber < $1.1.rollNumber) : ($0.1.rollNumber > $1.1.rollNumber)
                    
                }
                displayUser(userList: sortedByRollNumber)
            case 7 , 8:
                let sortedByAddress = dictionaryOfUsers.sorted{
                    tempChoice%2==0 ? ($0.1.address < $1.1.address) : ($0.1.address > $1.1.address)
                }
                displayUser(userList: sortedByAddress)
            default:
                print("Wrong choice entered");
            }
        }
    }
}


func displayUser(userList: Array<(key: Int, value: User)>){
    
    if(userList.count == 0){
        print("Nothing In There")
    }
    else{
        
        print("----------------------------------------------------------------------------------------------")
        print("Name                Roll Number             Age            Address           Courses")
        print("----------------------------------------------------------------------------------------------")
        for users in userList{
            print("\(users.value.name)                  \(users.value.rollNumber)                      \(users.value.age)                      \(users.value.address)             \(users.value.courseList)")
        }
    }
}


func deleteUser(rollNumber : Int){
    if(dictionaryOfUsers[rollNumber] != nil){
        dictionaryOfUsers.removeValue(forKey: rollNumber)
        print("Successfully deleted from the records")
    }
    else{
        print("User with the entered roll number not found")
    }
}

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
            if let currentUser = addUser(){ // this returns an object that contains all the user data.
                dictionaryOfUsers[currentUser.rollNumber] = currentUser
            }
        case "2" :
            sortAndDisplay()
        case "3" :
            print("Enter the roll number you wish to delete")
            var temp:String?
            var rollNumber:Int?
            repeat{
                print("Enter you roll number")
                temp = readLine()
                rollNumber = Int(temp!)
            }while(!isInt(value: temp))
            if let tempRollNumber = rollNumber{
                deleteUser(rollNumber: tempRollNumber)
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
