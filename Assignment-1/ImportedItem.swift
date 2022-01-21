//
//  ImportedItem.swift
//  Assignment-1
//
//  Created by Shubham on 17/01/22.
//

import Foundation

class ImportedItem: ItemDetails, TaxCaculations{
    
    // defining the function
    func calculateTax() -> (Double) {
        let importDuty = (10*price)/100;
        var surcharge:Double = 0
        if(importDuty+price <= 100){
            surcharge = 5
        }
        else if(importDuty+price <= 200){
            surcharge = 10
        }
        else {
            surcharge = 5*(importDuty+price)/100;
        }
        return importDuty+surcharge
    }
    
    func printTax(){
        let tax = calculateTax();
        
        print("Tax on the item --       \(tax)")
        print("Total cost       --      \(tax+price)")
        print("Quantity * Price --      \((tax+price)*Double(quantity ?? 1))")
        print("----------------------------------------------------")
        
    }
    
    
    
}
