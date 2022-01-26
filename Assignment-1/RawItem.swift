//
//  RawItem.swift
//  Assignment-1
//
//  Created by Shubham on 17/01/22.
//

import Foundation

class RawItem: ItemDetails, TaxCaculations{
    
    
    func calculateTax() -> (Double) {
        let tax = (12.5*price)/100;
        return tax
    }
    
    func populateTax(){
        self.tax = calculateTax()
    }

    
}

