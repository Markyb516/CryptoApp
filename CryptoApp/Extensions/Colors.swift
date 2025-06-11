//
//  Extensions.swift
//  CryptoApp
//
//  Created by Markus Buchanan on 1/20/25.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme{
    let accent =  Color(Constants.accentColor)
    let background = Color(Constants.background)
    let greenAppColor = Color(Constants.greenApp)
    let redAppColor = Color(Constants.redApp)
    let secondaryText = Color(Constants.secondary)
    
// MARK: -  Constants
    private struct Constants{
        static let accentColor = "AccentColor"
        static let background = "BackgroundColor"
        static let greenApp = "GreenAppColor"
        static let redApp = "RedAppColor"
        static let secondary = "SecondaryTextColor"
    }
}
