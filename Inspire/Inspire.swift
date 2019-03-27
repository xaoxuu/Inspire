//
//  Inspire.swift
//  Inspire
//
//  Created by xaoxuu on 2019/3/26.
//  Copyright © 2019 Titan Studio. All rights reserved.
//

import UIKit

public struct Inspire {

    public static var current = Inspire()
    
    public struct InColor {
        public var theme = UIColor("#FF9898")
        public var accent = UIColor("#1BCBFA")
        public var background = UIColor("#EFEFEF")
    }
    public struct InFont {
        public enum Style: String {
            case title = "title"
            case body = "body"
            case number = "number"
            case code = "code"
        }
        
        public var title = "AvenirNext-Bold"
        public var body = "ChalkboardSE-Regular"
        public var number = "Courier"
        public var code = "Menlo-Regular"
        
    }
    public struct InLayout {
        
        internal enum ScreenSize: Int {
            case unknown
            case iPhone3_5
            case iPhone4_0
            case iPhone4_7
            case iPhone5_5
            case iPhone5_8
            case iPhone6_1
            case iPhone6_5
            case iPad7_9
            case iPad9_7
            case iPad10_5
            case iPad11
            case iPad12_9
        }
        
        /// 设备常量
        public struct DeviceConst {
            
            /// 设备屏幕尺寸
            internal static let screenSize: ScreenSize = {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    // FIXME: 适配iPad
                    if let s = UIScreen.main.currentMode?.size {
                        switch s {
                        case CGSize(width: 1536, height: 2048):
                            return ScreenSize.iPad7_9
                        case CGSize(width: 1536, height: 2048):
                            return ScreenSize.iPad9_7
                        case CGSize(width: 1668, height: 2224):
                            return ScreenSize.iPad10_5
                        case CGSize(width: 1668, height: 2388):
                            return ScreenSize.iPad11
                        case CGSize(width: 2048, height: 2732):
                            return ScreenSize.iPad12_9
                        default:
                            break
                        }
                    }
                    return ScreenSize.iPad9_7
                } else if UIDevice.current.userInterfaceIdiom == .phone {
                    if let s = UIScreen.main.currentMode?.size {
                        switch s {
                        case CGSize(width: 320, height: 480), CGSize(width: 640, height: 960):
                            return ScreenSize.iPhone3_5
                        case CGSize(width: 640, height: 1136):
                            return ScreenSize.iPhone4_0
                        case CGSize(width: 750, height: 1334):
                            return ScreenSize.iPhone4_7
                        case CGSize(width: 1242, height: 2208):
                            return ScreenSize.iPhone5_5
                        case CGSize(width: 1125, height: 2436):
                            return ScreenSize.iPhone5_8
                        case CGSize(width: 828, height: 1792):
                            return ScreenSize.iPhone6_1
                        case CGSize(width: 1242, height: 2688):
                            return ScreenSize.iPhone6_5
                        default:
                            break
                        }
                    } else {
                        return ScreenSize.iPhone4_7
                    }
                }
                return ScreenSize.unknown
            }()
            
            /// 取决于设备，无论横竖屏、是否隐藏，此值不变。要想取当前值，用SafeArea实例
            public static let statusBarWindowHeight: CGFloat = {
                if let w = UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow {
                    if let b = w.value(forKey: "statusBar") as? UIView {
                        return b.frame.size.height
                    }
                }
                return 20
            }()
            
            /// 竖屏时底部的安全区域高度
            public static let bottomSafeAreaHeightOnPortrait: CGFloat = {
                if screenSize.isNewPhone {
                    return 34
                } else if screenSize == .iPad11 {
                    return 21
                }
                return 0
            }()
            
            /// 横屏时底部的安全区域高度
            public static let bottomSafeAreaHeightOnLandscape: CGFloat = {
                if screenSize.isNewPhone {
                    return 21
                } else if screenSize == .iPad11 {
                    return 21
                }
                return 0
            }()
        }
        
        /// 屏幕布局安全区域。
        /// 如果支持横屏，当改变屏幕方向后需要调用 updatedSafeArea() 重新获取
        public static var safeAreaInsets: UIEdgeInsets = {
            return getCurrentSafeAreaInsets()
        }()
        
        /// 屏幕布局安全区域。
        /// 如果支持横屏，当改变屏幕方向后需要调用 updatedSafeArea() 重新获取
        public var safeAreaInsets: UIEdgeInsets {
            return Inspire.InLayout.safeAreaInsets
        }
        
        static func getCurrentSafeAreaInsets() -> UIEdgeInsets {
            debugPrint("重新获取当前屏幕安全区域")
            var top = CGFloat(0), left = CGFloat(0), bottom = CGFloat(0), right = CGFloat(0)
            if UIApplication.shared.statusBarOrientation == .portrait {
                top = InLayout.DeviceConst.statusBarWindowHeight
                bottom = InLayout.DeviceConst.bottomSafeAreaHeightOnPortrait
            } else {
                bottom = InLayout.DeviceConst.bottomSafeAreaHeightOnLandscape
                left = InLayout.DeviceConst.statusBarWindowHeight
                right = InLayout.DeviceConst.statusBarWindowHeight
            }
            let inset = UIEdgeInsets.init(top: top, left: left, bottom: bottom, right: right)
            return inset
        }
        /// 更新屏幕布局安全区域
        ///
        /// - Returns: 屏幕布局安全区域
        @discardableResult
        public static func updatedSafeAreaInsets() -> UIEdgeInsets {
            safeAreaInsets = getCurrentSafeAreaInsets()
            return safeAreaInsets
        }
        
        /// 更新屏幕布局安全区域
        ///
        /// - Returns: 屏幕布局安全区域
        @discardableResult
        public func updatedSafeAreaInsets() -> UIEdgeInsets {
            return InLayout.updatedSafeAreaInsets()
        }
        
        /// 圆角
        public struct CornerRadius {
            public var large = CGFloat(16)
            public var medium = CGFloat(12)
            public var regular = CGFloat(8)
            public var small = CGFloat(4)
        }
        
        /// 填充
        public var padding = CGFloat(8)
        
        /// 余量
        public var margin = CGFloat(16)
        
        /// 圆角
        public var cornerRadius = CornerRadius()
        
        /// 行高
        public var rowHeight = CGFloat(50)
        
    }

    
    /// 颜色
    public var color = InColor()
    
    /// 字体
    public var font = InFont()
    
    /// 布局
    public var layout = InLayout()
    
    public init() {
        debugPrint("init")
    }
   
    /// 根据字典来创建主题模型
    ///
    /// - Parameter dictionary: 字典
    public init(dictionary: [String: Any]) {
        
        if let dict = dictionary["Color"] as? [String: String] {
            color.theme = UIColor(dict["theme"] ?? "#000000")
            color.accent = UIColor(dict["accent"] ?? "#000000")
            color.background = UIColor(dict["background"] ?? "#000000")
        }
        if let dict = dictionary["Font"] as? [String: String] {
            font.title = dict["title"] ?? ""
            font.body = dict["body"] ?? ""
            font.number = dict["number"] ?? ""
            font.code = dict["code"] ?? ""
        }
        if let dict = dictionary["Layout"] as? [String: Any] {
            if let str = dict["padding"] as? String {
                if let d = Double(str) {
                    layout.padding = CGFloat(d)
                }
            }
            if let str = dict["margin"] as? String {
                if let d = Double(str) {
                    layout.margin = CGFloat(d)
                }
            }
            if let dict2 = dict["cornerRadius"] as? [String: String] {
                if let str = dict2["large"] {
                    if let d = Double(str) {
                        layout.cornerRadius.large = CGFloat(d)
                    }
                }
                if let str = dict2["medium"] {
                    if let d = Double(str) {
                        layout.cornerRadius.medium = CGFloat(d)
                    }
                }
                if let str = dict2["regular"] {
                    if let d = Double(str) {
                        layout.cornerRadius.regular = CGFloat(d)
                    }
                }
                if let str = dict2["small"] {
                    if let d = Double(str) {
                        layout.cornerRadius.small = CGFloat(d)
                    }
                }
            }
            
        }
        
    }
    
    /// 应用主题
    ///
    /// - Parameter ins: 主题模型
    public static func apply(_ ins: Inspire) {
        current = ins
    }
    
    /// 导出主题
    ///
    /// - Returns: 字典
    public func export() -> [String: [String: Any]] {
        var result = [String: [String: Any]]()
        let fontDict = [InFont.Style.title.rawValue: font.title,
                        InFont.Style.body.rawValue: font.body,
                        InFont.Style.number.rawValue: font.number,
                        InFont.Style.code.rawValue: font.code]
        let colorDict = ["theme": color.theme.hexString(),
                         "accent": color.accent.hexString(),
                         "background": color.background.hexString()]
        var layoutDict = [String: Any]()
        layoutDict["padding"] = String(Double(layout.padding))
        layoutDict["margin"] = String(Double(layout.margin))
        let cornerRadiusDict = ["large": String(Double(layout.cornerRadius.large)),
                                "medium": String(Double(layout.cornerRadius.medium)),
                                "regular": String(Double(layout.cornerRadius.regular)),
                                "small": String(Double(layout.cornerRadius.small))]
        layoutDict["cornerRadius"] = cornerRadiusDict
        result["Font"] = fontDict
        result["Color"] = colorDict
        result["Layout"] = layoutDict
        return result
    }
    
    
}
