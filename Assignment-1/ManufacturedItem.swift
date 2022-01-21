//
//  ManufacturedItem.swift
//  Assignment-1
//
//  Created by Shubham on 17/01/22.
//

import Foundation

class ManufacturedItem: ItemDetails, TaxCaculations{


    func calculateTax() -> (Double) {
        let tax = (12.5*price)/100 + 2*(price + (12.5*price)/100)/100;
        return tax
    }
    
    func printTax(){
        
        let tax = calculateTax();
        
        print("Tax on the item --       \(tax)")
        print("Total cost       --      \(tax+price)")
        print("Quantity * Price --      \((tax+price)*Double(quantity ?? 1))")
        print("----------------------------------------------------")

        
    }
}
