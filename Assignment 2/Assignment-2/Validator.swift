//
//  Validator.swift
//  Assignment-2
//
//  Created by Shubham on 26/01/22.
//

import Foundation

class Validator{
    
    func nameValidator(name : String?) ->Bool{
        if(name == nil){
            print("wrong name entered")
            return false
        }
        if let tempName = name{
            if(tempName.isEmpty == true){
                print("wrong name entered")
                return false
            }
            else{
                return true
            }
        }
        else{
            return true
        }
    }
    
    // Job of this function is to validate whether the input given as string by the users, is valid and contains any of the
    // four madatory courses among A B C D E F
    
    func courseValidation(inputLine : String) -> (Bool){
        let array = inputLine.components(separatedBy: " ")
        
        // checking if same course has been entered twice
        
        
        var hash = [String:Int]()
        for courses in array{
            if(hash[courses] != nil){
                return false
            }
            else{
                hash[courses] = 1
            }
        }
        
        if(array.count < 4){
            return false
        }
        else if( array.allSatisfy({$0 == "A" || $0 == "B" || $0 == "C" || $0 == "D" || $0 == "E" || $0 == "F"})){
            return true
        }
        else{
            return false
        }
        
    }
    
    func isInt(value:String?) -> Bool{
        if(value == nil) {
            print("Wrong value Entered")
            return false
        }
        if let tempValue = value{
            if Int(tempValue) != nil {
                return true
            }
            else{
                return false
            }
        }
        else{
            print("Wrong value entered")
            return false
        }
    }
    
}
