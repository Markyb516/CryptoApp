//
//  Currency.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/23/25.
//

import Foundation


extension Double{
    
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
    
   
    func marketDataFormat() -> String? {
        switch self {
            
        case 1_000_000_000_000...:
            let roundedNumber = self / 1_000_000_000_000
            guard let formattedResult =  roundedNumber.formatToString(maxDecimal: 2, minDecimal: 2) else {return nil}
            return "\(formattedResult)Tr"
            
        case 1_000_000_000...:
            let roundedNumber = self / 1_000_000_000
            guard let formattedResult =  roundedNumber.formatToString(maxDecimal: 2, minDecimal: 2) else {return nil}
            return "\(formattedResult)Bn"
        case 1_000_000...:
            let roundedNumber = self / 1_000_000
            guard let formattedResult =  roundedNumber.formatToString(maxDecimal: 2, minDecimal: 2) else {return nil}
            return "\(formattedResult)M"
        case 1_000...:
            let roundedNumber = self / 1_000
            guard let formattedResult =  roundedNumber.formatToString(maxDecimal: 2, minDecimal: 2) else {return nil}
            return "\(formattedResult)K"

        default:
           return self.formatToString(maxDecimal: 2, minDecimal: 2)
        }
    
    
    }
        
    
    }
    
 
    
    
    


 

