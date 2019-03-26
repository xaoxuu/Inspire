//
//  LayoutUtil.swift
//  Inspire
//
//  Created by xaoxuu on 2019/3/26.
//  Copyright © 2019 Titan Studio. All rights reserved.
//

import UIKit

public class InLayout {
    
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
        static let screenSize: ScreenSize = {
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
    public static var safeArea = updatedSafeArea()
    
    /// 更新屏幕布局安全区域
    ///
    /// - Returns: 屏幕布局安全区域
    @discardableResult
    public static func updatedSafeArea() -> UIEdgeInsets {
        debugPrint("重新获取屏幕安全区域")
        var top = CGFloat(0), left = CGFloat(0), bottom = CGFloat(0), right = CGFloat(0)
        if InLayout.DeviceConst.screenSize.isNewPhone {
            if UIApplication.shared.statusBarOrientation == .portrait {
                top = InLayout.DeviceConst.statusBarWindowHeight
                bottom = InLayout.DeviceConst.bottomSafeAreaHeightOnPortrait
            } else {
                bottom = InLayout.DeviceConst.bottomSafeAreaHeightOnLandscape
                left = InLayout.DeviceConst.statusBarWindowHeight
                right = InLayout.DeviceConst.statusBarWindowHeight
            }
        } else {
            
        }
        let inset = UIEdgeInsets.init(top: top, left: left, bottom: bottom, right: right)
        safeArea = inset
        return inset
    }
    
    
    public static let shared = Inspire.current.layout
    
    public var safeArea = InLayout.safeArea
    
    public func updatedSafeArea() -> UIEdgeInsets {
        return InLayout.updatedSafeArea()
    }
    
    public struct CornerRadius {
        public var large = CGFloat(16)
        public var medium = CGFloat(12)
        public var regular = CGFloat(8)
        public var small = CGFloat(4)
    }
    public var padding = CGFloat(8)
    public var margin = CGFloat(16)
    public var cornerRadius = CornerRadius()
    
}

extension InLayout.ScreenSize {
    public var isNewPhone: Bool {
        if UIDevice.current.userInterfaceIdiom == .phone {
            let ss = InLayout.DeviceConst.screenSize
            if ss == .iPhone3_5 || ss == .iPhone4_0 || ss == .iPhone4_7 || ss == .iPhone5_5 {
                return false
            } else {
                return true
            }
        }
        return false
    }
    public var isNewPad: Bool {
        if UIDevice.current.userInterfaceIdiom == .pad {
            let ss = InLayout.DeviceConst.screenSize
            if ss == .iPad7_9 || ss == .iPad9_7 || ss == .iPad10_5 || ss == .iPad12_9 {
                return false
            } else {
                return true
            }
        }
        return false
    }
    
}

