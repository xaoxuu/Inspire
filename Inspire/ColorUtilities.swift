//
//  ColorUtil.swift
//  Inspire
//
//  Created by xaoxuu on 2019/3/26.
//  Copyright © 2019 Titan Studio. All rights reserved.
//

import UIKit


// MARK: - 快速get
public extension UIColor {
    
    public static let theme = Inspire.current.color.theme
    public static let accent = Inspire.current.color.accent
    public static let background = Inspire.current.color.background
    
}

public extension UIColor {
    static let ax_yellow = UIColor.init(red: 255/255, green: 235/255, blue: 59/255, alpha: 1)
    static let ax_red = UIColor.init(red: 244/255, green: 67/255, blue: 54/255, alpha: 1)
    static let ax_green = UIColor.init(red: 76/255, green: 175/255, blue: 80/255, alpha: 1)
    static let ax_blue = UIColor.init(red: 82/255, green: 161/255, blue: 248/255, alpha: 1)
    
    internal func darken(_ ratio: CGFloat = 0.5) -> UIColor {
        var red = CGFloat(0)
        var green = CGFloat(0)
        var blue = CGFloat(0)
        var alpha = CGFloat(0)
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        red = red * (1 - ratio)
        green = green * (1 - ratio)
        blue = blue * (1 - ratio)
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    internal func lighten(_ ratio: CGFloat = 0.5) -> UIColor {
        var red = CGFloat(0)
        var green = CGFloat(0)
        var blue = CGFloat(0)
        var alpha = CGFloat(0)
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        red = red * (1 - ratio) + ratio
        green = green * (1 - ratio) + ratio
        blue = blue * (1 - ratio) + ratio
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    internal func textColor() -> UIColor {
        func isLightColor() -> Bool {
            if self == UIColor.clear {
                return true
            }
            var red = CGFloat(0)
            var green = CGFloat(0)
            var blue = CGFloat(0)
            var alpha = CGFloat(0)
            self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            let grayLevel = red * 0.299 + green * 0.587 + blue * 0.114
            if grayLevel >= 192.0/255.0 {
                return true
            } else {
                return false
            }
        }
        
        if isLightColor() {
            return .darkText
        } else {
            return .white
        }
    }
    
    convenience init(hex: String) {
        func filter(hex: String) -> NSString{
            let set = NSCharacterSet.whitespacesAndNewlines
            var str = hex.trimmingCharacters(in: set).lowercased()
            if str.hasPrefix("#") {
                str = String(str.suffix(str.count-1))
            } else if str.hasPrefix("0x") {
                str = String(str.suffix(str.count-2))
            }
            return NSString(string: str)
        }
        let hex = filter(hex: hex)
        let length = hex.length
        guard length == 3 || length == 4 || length == 6 || length == 8 else {
            print("无效的hex")
            self.init(hex: "000")
            return
        }
        func floatFrom(_ hex: String) -> CGFloat {
            var result = Float(0)
            Scanner(string: "0x"+hex).scanHexFloat(&result)
            var maxStr = "0xf"
            if length > 5 {
                maxStr = "0xff"
            }
            var max = Float(0)
            Scanner(string: maxStr).scanHexFloat(&max)
            result = result / max
            return CGFloat(result)
        }
        
        func substring(_ hex: NSString, loc: Int) -> String {
            if length == 3 || length == 4 {
                return hex.substring(with: NSRange.init(location: loc, length: 1))
            } else if length == 6 || length == 8 {
                return hex.substring(with: NSRange.init(location: 2*loc, length: 2))
            } else {
                return ""
            }
        }
        
        let r = floatFrom(substring(hex, loc: 0))
        let g = floatFrom(substring(hex, loc: 1))
        let b = floatFrom(substring(hex, loc: 2))
        var a = CGFloat(1)
        if length == 4 || length == 8 {
            a = floatFrom(substring(hex, loc: 3))
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    func hexString() -> String {
        func maxHexValue() -> CGFloat {
            var max = Float(0)
            Scanner(string: "0xff").scanHexFloat(&max)
            return CGFloat(max)
        }
        var r = CGFloat(0)
        var g = CGFloat(0)
        var b = CGFloat(0)
        var a = CGFloat(1)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rr = String(format: "%02X", UInt32(r*maxHexValue()))
        let gg = String(format: "%02X", UInt32(g*maxHexValue()))
        let bb = String(format: "%02X", UInt32(b*maxHexValue()))
        let aa = String(format: "%02X", UInt32(a*maxHexValue()))
        
        print(rr,gg,bb,aa)
        return "#" + rr + gg + bb + aa
    }
}

