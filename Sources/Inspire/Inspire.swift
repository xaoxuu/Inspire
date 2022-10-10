//
//  Inspire.swift
//  Inspire
//
//  Created by xaoxuu on 2019/3/26.
//  Copyright © 2019 xaoxuu.com. All rights reserved.
//

import UIKit

internal let ipr = Inspire.shared

public struct Inspire {

    /// 当前实例
    public static var shared = Inspire()
    /// 当前实例
    public static var current: Inspire {
        get {
            return shared
        }
        set {
            shared = newValue
        }
    }
    
    /// 颜色
    public struct InColor {
        
        /// 主题色
        public var theme = UIColor("#FF6868")
        
        /// 强调色
        public var accent = UIColor("#1BCBFA")
        
        /// 背景色
        public var background = UIColor("#EFEFEF")
        
        /// 成功的颜色
        public var success = UIColor("#34C749")
        
        /// 警告的颜色
        public var warning = UIColor("#FDBD41")
        
        /// 失败的颜色
        public var failure = UIColor("#F44336")
    }
    
    /// 字体
    public struct InFont {
        
        /// 字体
        ///
        /// - title: 标题部分字体名
        /// - body: 正文部分字体名
        /// - number: 数字部分字体名
        /// - code: 代码部分字体名
        public enum Scheme: String {
            case title = "title"
            case body = "body"
            case number = "number"
            case code = "code"
        }
        
        /// 标题部分字体名
        public var title = ""
        /// 正文部分字体名
        public var body = ""
        /// 数字部分字体名
        public var number = ""
        /// 代码部分字体名
        public var code = ""
        
        /// 字号缩放倍数
        public var scale = CGFloat(1)
        
    }
    
    /// 布局
    public struct InLayout {
        
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
        
        /// 屏幕
        public struct InScreen {}
        
    }


    /// 颜色
    public var color = InColor()
    
    /// 字体
    public var font = InFont()
    
    /// 布局
    public var layout = InLayout()
    
    /// 常量
    public var screen = InLayout.InScreen()
    
    private static var currentRootVC: UIViewController?
    /// 默认可以自动获取，如果获取失败请手动设置
    public var rootVC: UIViewController? {
        get {
            if let vc = Inspire.currentRootVC {
                return vc
            } else {
                // 尝试获取RootVC
                var windows: [UIWindow]
                if #available(iOS 13.0, *) {
                    windows = windowScene?.windows ?? []
                } else {
                    windows = UIApplication.shared.windows
                }
                let ws = windows.filter { (w) -> Bool in
                    // 去除掉诸如 UITextEffectsWindow 这样的类，去掉隐藏的Window
                    if "\(type(of:w))" == "UIWindow" && w.isHidden == false && w.windowLevel == .normal {
                        return true
                    } else {
                        return false
                    }
                }
                for w in ws {
                    if let vc = w.rootViewController {
                        Inspire.currentRootVC = vc
                        return vc
                    }
                }
                print("⚠️自动获取根控制器失败，请手动设置根控制器")
                return nil
            }
        }
        set {
            Inspire.currentRootVC = newValue
        }
    }
    
    /// 默认可以自动获取，如果获取失败请手动设置
    @available(iOS 13.0, *)
    private static var currentWindowScene: UIWindowScene?
    
    /// 默认可以自动获取，如果获取失败请手动设置
    @available(iOS 13.0, *)
    public var windowScene: UIWindowScene? {
        get {
            if let scene = Inspire.currentWindowScene {
                return scene
            } else {
                return UIWindowScene.currentWindowScene
            }
        }
        set {
            Inspire.currentWindowScene = newValue
        }
    }
    
    /// 创建默认实例
    public init() {
        
    }
    
    
}


// MARK: - 多主题
extension Inspire {
    
    /// 根据字典来创建主题模型
    ///
    /// - Parameter dictionary: 字典
    public init(_ dictionary: [String: Any]) {
        if let dict = dictionary["color"] as? [String: String] {
            color.theme = UIColor(dict["theme"] ?? "#FF6868")
            color.accent = UIColor(dict["accent"] ?? "#1BCBFA")
            color.background = UIColor(dict["background"] ?? "#EFEFEF")
            color.success = UIColor(dict["success"] ?? "#34C749")
            color.warning = UIColor(dict["warning"] ?? "#FDBD41")
            color.failure = UIColor(dict["failure"] ?? "#F44336")
        }
        if let dict = dictionary["font"] as? [String: String] {
            font.title = dict["title"] ?? ""
            font.body = dict["body"] ?? ""
            font.number = dict["number"] ?? ""
            font.code = dict["code"] ?? ""
            if let str = dict["scale"] {
                if let d = Double(str) {
                    font.scale = CGFloat(d)
                }
            }
        }
        if let dict = dictionary["layout"] as? [String: Any] {
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
            if let str = dict["rowHeight"] as? String {
                if let d = Double(str) {
                    layout.rowHeight = CGFloat(d)
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
        shared = ins
        NotificationCenter.default.post(name: Inspire.Event.didUpdate, object: ins)
    }
    
    /// 导出主题
    ///
    /// - Returns: 字典
    public func export() -> [String: [String: Any]] {
        var result = [String: [String: Any]]()
        let fontDict = [InFont.Scheme.title.rawValue: font.title,
                        InFont.Scheme.body.rawValue: font.body,
                        InFont.Scheme.number.rawValue: font.number,
                        InFont.Scheme.code.rawValue: font.code,
                        "scale": String(Double(font.scale))]
        let colorDict = ["theme": color.theme.hexString,
                         "accent": color.accent.hexString,
                         "background": color.background.hexString,
                         "success": color.success.hexString,
                         "warning": color.warning.hexString,
                         "failure": color.failure.hexString]
        var layoutDict = [String: Any]()
        layoutDict["padding"] = String(Double(layout.padding))
        layoutDict["margin"] = String(Double(layout.margin))
        layoutDict["rowHeight"] = String(Double(layout.rowHeight))
        let cornerRadiusDict = ["large": String(Double(layout.cornerRadius.large)),
                                "medium": String(Double(layout.cornerRadius.medium)),
                                "regular": String(Double(layout.cornerRadius.regular)),
                                "small": String(Double(layout.cornerRadius.small))]
        layoutDict["cornerRadius"] = cornerRadiusDict
        result["font"] = fontDict
        result["color"] = colorDict
        result["layout"] = layoutDict
        return result
    }
    
}

public extension Inspire {
    struct Event {
        public static let didUpdate = Notification.Name.init(rawValue: "Inspire.didUpdate")
    }
     
    
}

