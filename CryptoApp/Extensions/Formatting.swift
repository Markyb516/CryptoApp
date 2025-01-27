//
//  Currency.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/23/25.
//

import Foundation


extension Double{
    
    func toCurrency() -> String? {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        if let currency = formatter.string(from: NSNumber(value: self)){
            return "$\(currency)"
        }
        
        return nil
        
    }
    
    func toPercentage() -> String? {
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        if let percentage = formatter.string(from: NSNumber(value: self)){
            return "\(percentage)%"
        }
        
        return nil
    }
    
    func formatToString (maxDecimal : Int , minDecimal : Int) -> String? {
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = maxDecimal
        formatter.minimumFractionDigits = minDecimal
        
        if let number = formatter.string(from: NSNumber(value: self)){
            return "\(number)"
        }
        
        return nil
      
    }
    
}
