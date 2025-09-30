//
//  Fonts.swift
//  DousSpint
//
//  Created by Никита on 30.09.2025.
//

// Fonts.swift
import SwiftUI

extension Font {
    static let calistogaTitle = Font.custom("Calistoga-Regular", size: 32)
    static let calistogaHeader = Font.custom("Calistoga-Regular", size: 24)
    static let calistogaBody = Font.custom("Calistoga-Regular", size: 17)
    
    static func calistoga(size: CGFloat) -> Font {
        return Font.custom("Calistoga-Regular", size: size)
    }
    
    static func poppins(_ name: String, size: CGFloat) -> Font {
        return Font.custom(name, size: size)
    }
    
    static let poppinsBlack = Font.custom("Poppins-Black", size: 16)
    static let poppinsBold = Font.custom("Poppins-Bold", size: 16)
    static let poppinsSemiBold = Font.custom("Poppins-SemiBold", size: 16)
    static let poppinsMedium = Font.custom("Poppins-Medium", size: 16)
    static let poppinsRegular = Font.custom("Poppins-Regular", size: 16)
    static let poppinsLight = Font.custom("Poppins-Light", size: 16)
}

enum PoppinsWeight {
    case black, bold, semiBold, medium, regular, light
    
    var fontName: String {
        switch self {
        case .black: return "Poppins-Black"
        case .bold: return "Poppins-Bold"
        case .semiBold: return "Poppins-SemiBold"
        case .medium: return "Poppins-Medium"
        case .regular: return "Poppins-Regular"
        case .light: return "Poppins-Light"
        }
    }
}

extension Font {
    static func poppins(_ weight: PoppinsWeight = .regular, size: CGFloat) -> Font {
        return Font.custom(weight.fontName, size: size)
    }
}

