
import Foundation

class ItemDetails{
     var name: String
     var price: Double
     var quantity: Int
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
        print("Quantity of the item     \(quantity)")
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
    
    var price:Double = -1
    var name:String = ""
    var type:String = ""
    var quantity:Int? = 1
    
    func isItCommand(inputString:String)-> (Bool){  // return true if current string is not a command else returns false
        if(inputString=="-name"){//
            return true
        }
        else if(inputString=="-price"){
            return true
        }
        else if(inputString=="-quantity"){
            return true
        }
        else if(inputString=="-type"){
            return true
        }
        else{
            return false
        }
    }
    
    print("Enter the details of the items")
  
    if let inputLine = readLine(){
        let inputParts = inputLine.components(separatedBy: " ")
        // considering the input of name differently because it can have more than one word.
        var indexOfName = 1
        if(inputParts[0] != "-name"){ // first command must be name
            print("wrong input format")
        }
        else{
            
            // using while loop to extract name.
            
            while( indexOfName < inputParts.endIndex && !isItCommand(inputString: inputParts[indexOfName]) && indexOfName<inputParts.endIndex){ // continue looping till we don't hit another command.
                name += inputParts[indexOfName] + " ";
                indexOfName+=1;
            }
            
           
        }
            // using switch cases to input other details i.e., price, quantity and price.
        // iterating over the whole input line and extracting information and type casting it .
        for index in stride(from:inputParts.startIndex, to:(inputParts.endIndex),by: 1){
                let currentString = inputParts[index];
                switch currentString{
                case "-price":
                    price = isItCommand(inputString: inputParts[index+1]) ? -1 : Double(inputParts[index+1]) ?? 0.0
                case "-quantity":
                    quantity = isItCommand(inputString:inputParts[index+1]) ? 1 : Int(inputParts[index+1])
                case "-type":
                    type = isItCommand(inputString:inputParts[index+1]) ? "" : inputParts[index+1]
                default:
                    continue
                }
            
        }
        // checking if all the inputs are valid.
        if(name==""){
            print("Name not Entered")
        }
        else if(type==""){
            print("Type not Entered")
        }
        else if(price == -1){
            print("Price Not Entered")
        }
        else{
           // classifying objects on the basis of their type and appending into array of their type (list)
            if(type == "imported"){
                let importedItem = ImportedItem(name, price , quantity ?? 1, type)
                importedItemList.append(importedItem)
            }
            else if(type == "raw"){
                let rawItem = RawItem(name, price, quantity ?? 1, type)
                rawItemList.append(rawItem)
            }
            else if(type == "manufactured"){
                let manufacturedItem = ManufacturedItem(name, price, quantity ?? 1, type)
                manufacturedItemList.append(manufacturedItem)
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
