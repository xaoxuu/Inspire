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
    
    static var theme: UIColor {
        return Inspire.current.color.theme
    }
    static var accent: UIColor {
        return Inspire.current.color.accent
    }
    static var background: UIColor {
        return Inspire.current.color.background
    }
    static var success: UIColor {
        return Inspire.current.color.success
    }
    static var warning: UIColor {
        return Inspire.current.color.warning
    }
    static var failure: UIColor {
        return Inspire.current.color.failure
    }
    
}

// MARK: - 颜色工具
public extension UIColor {
    
    /// 变深
    ///
    /// - Parameter ratio: 比例
    /// - Returns: 变深后的颜色
    func darken(_ ratio: CGFloat = 0.5) -> UIColor {
        var red = CGFloat(0)
        var green = CGFloat(0)
        var blue = CGFloat(0)
        var alpha = CGFloat(0)
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        red = red * (1 - ratio)
        green = green * (1 - ratio)
        blue = blue * (1 - ratio)
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 变浅
    ///
    /// - Parameter ratio: 比例
    /// - Returns: 变浅后的颜色
    func lighten(_ ratio: CGFloat = 0.5) -> UIColor {
        var red = CGFloat(0)
        var green = CGFloat(0)
        var blue = CGFloat(0)
        var alpha = CGFloat(0)
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        red = red * (1 - ratio) + ratio
        green = green * (1 - ratio) + ratio
        blue = blue * (1 - ratio) + ratio
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 当前颜色中的文字适合的颜色（参考）
    var forText: UIColor {
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
    
    
    /// 根据hex字符串创建颜色
    ///
    /// - Parameter hex: hex字符串
    convenience init(_ hex: String) {
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
            self.init("000")
            return
        }
        func floatValue(from hex: String) -> CGFloat {
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
        
        func substring(of hex: NSString, loc: Int) -> String {
            if length == 3 || length == 4 {
                return hex.substring(with: NSRange.init(location: loc, length: 1))
            } else if length == 6 || length == 8 {
                return hex.substring(with: NSRange.init(location: 2*loc, length: 2))
            } else {
                return ""
            }
        }
        
        let r = floatValue(from: substring(of: hex, loc: 0))
        let g = floatValue(from: substring(of: hex, loc: 1))
        let b = floatValue(from: substring(of: hex, loc: 2))
        var a = CGFloat(1)
        if length == 4 || length == 8 {
            a = floatValue(from: substring(of: hex, loc: 3))
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    /// 生成当前颜色的hex字符串
    var hexString: String {
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

