
import Foundation

class ItemDetails{
    var name: String
    var price: Double
    var quantity: Int? = 1
    var type: String
    
    init(_ name:String,_ price:Double,_ quantity:Int, _ type: String){
        self.name = name
        self.price = price
        self.quantity = quantity
        self.type = type
    }
    
    func printItemDetail(){
        print("Name of the item         \(name)")
        print("Type of the item         \(type)")
        print("Price of the item        \(price)")
        print("Quantity of the item     \(quantity ?? 1)")
    }
    
}

// a protocol declaration for tax calculations
protocol TaxCaculations{
    func calculateTax()->(Double)
    func printTax()
}





// array decleration for storing the details of the items.

var rawItemList = [RawItem]()
var manufacturedItemList = [ManufacturedItem]()
var importedItemList = [ImportedItem]()


func inputItems(){
    
    var price:Double?
    var name:String?
    var type:String?
    var quantity:Int? = 1
    
    func isItCommand(inputString:String)-> (Bool){  // return true if current string is a command else returns false
        if(inputString==Constants.commandName){//
            return true
        }
        else if(inputString==Constants.commandPrice){
            return true
        }
        else if(inputString==Constants.commandType){
            return true
        }
        else if(inputString==Constants.commandQuantity){
            return true
        }
        else{
            return false
        }
    }
    
    print("Enter the details of the items")
    
    if let inputLine = readLine(){
        let inputParts = inputLine.components(separatedBy: " ") // Breaking the line into string components
        
        // considering the input of name differently because it can have more than one word.
        var indexOfName = 1
        if(inputParts[0] != Constants.commandName){ // first command must be name
            print("wrong input format")
        }
        else{
            name=""
            
            // using while loop to extract name.
            while( indexOfName < inputParts.endIndex && !isItCommand(inputString: inputParts[indexOfName])){ // continue looping till we don't hit another command.
                name! += inputParts[indexOfName] + " ";
                indexOfName+=1;
            }
            
            
        }
        // using switch cases to input other details i.e., price, quantity and price.
        // iterating over the whole input line and extracting information and type casting it .
        for index in stride(from:inputParts.startIndex, to:(inputParts.endIndex),by: 1){
            let currentString = inputParts[index];
            switch currentString{
                
                /* ternary operator is used to check if two commands are adjacent which is an incorrect input*/
                
            case Constants.commandPrice:
                price = isItCommand(inputString: inputParts[index+1]) ? -1 : Double(inputParts[index+1]) ?? 0.0
            case Constants.commandQuantity:
                quantity = isItCommand(inputString:inputParts[index+1]) ? 1 : Int(inputParts[index+1])
            case Constants.commandType:
                type = isItCommand(inputString:inputParts[index+1]) ? "" : inputParts[index+1]
            default:
                continue
            }
            
        }
        // checking if all the inputs are valid.
        if(name==nil){
            print("Name not Entered")
        }
        else if(type == nil){
            print("Type not Entered")
        }
        else if(price == nil){
            print("Price Not Entered")
        }
        else{
            // classifying objects on the basis of their type and appending into an array of their type (list)
            if(type == Constants.importedItem){
                if let tempName = name, let tempPrice = price , let tempType = type{
                    let importedItem = ImportedItem(tempName, tempPrice , quantity ?? 1, tempType)
                    importedItemList.append(importedItem)
                }
            }
            else if(type == Constants.rawItem){
                if let tempName = name, let tempPrice = price , let tempType = type{
                    let rawItem = ImportedItem(tempName, tempPrice , quantity ?? 1, tempType)
                    importedItemList.append(rawItem)
                }
            }
            else if(type == Constants.manufacturedItem){
                if let tempName = name, let tempPrice = price , let tempType = type{
                    let manufacturedItem = ImportedItem(tempName, tempPrice , quantity ?? 1, tempType)
                    importedItemList.append(manufacturedItem)
                }
            }
        }
    }
    else{
        print("Invalid Input")
    }
}

// starting point of the code
func driver(){
    print("Hi , Welcome to this console program");
    while(true){
        print("Do you want to enter details of any other item (y/n)")
        if let temp = readLine(){
            if(temp == "y"){
                inputItems()
            }
            else if(temp == "n"){
                break;
            }
            else{
                print("wrong input");
            }
        }
        
    }
    
    
    // Finally Printing the information about each item
    
    for elements in rawItemList{
        elements.printItemDetail()
        elements.printTax()
    }
    for elements in manufacturedItemList{
        elements.printItemDetail()
        elements.printTax()
    }
    for elements in importedItemList{
        elements.printItemDetail()
        elements.printTax()
    }
    
    
}


driver()
