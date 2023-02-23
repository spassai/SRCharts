import Foundation
import SwiftUI
#if canImport(UIKit)
import UIKit
#else
import AppKit
typealias UIColor = NSColor
#endif

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Color {
    static func rgb(c: Double, o: Double  = 1) -> Color {
        return Color(Color.RGBColorSpace.sRGB, red: c / 255, green: c / 255, blue: c / 255, opacity: o)
    }
    
    static func rgb(r: Double, g: Double, b: Double, o: Double  = 1) -> Color {
        return Color(Color.RGBColorSpace.sRGB, red: r / 255, green: g / 255, blue: b / 255, opacity: o)
    }
    
    static func hex(_ hexString: String, o: Double = 1) -> Color {
        guard hexString.count == 6 else { return .black}
        
        let r = Double(Int64(hexString.Substring(from: 0, to: 1), radix: 16)!)
        let g = Double(Int64(hexString.Substring(from: 2, to: 3), radix: 16)!)
        let b = Double(Int64(hexString.Substring(from: 4, to: 5), radix: 16)!)
        
        return Color(Color.RGBColorSpace.sRGB, red: r / 255, green: g / 255, blue: b / 255, opacity: o)
    }
    
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    func red() -> Double {
        if let components = UIColor(self).cgColor.components {
            if components.count >= 3 {
                return components[0]
            }
        }
        
        return 0
    }
    
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    func green() -> Double {
        if let components = UIColor(self).cgColor.components {
            if components.count >= 3 {
                return components[1]
            }
        }
        
        return 0
    }
    
    @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
    func blue() -> Double {
        if let components = UIColor(self).cgColor.components {
            if components.count >= 3 {
                return components[2]
            }
        }
        
        return 0
    }
}
