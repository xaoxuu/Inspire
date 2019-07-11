//
//  LayoutUtil.swift
//  Inspire
//
//  Created by xaoxuu on 2019/3/26.
//  Copyright © 2019 Titan Studio. All rights reserved.
//

import UIKit

// MARK: - 设备布局常量
public extension Inspire.InLayout {
    
    /// 设备常量
    struct InDevice {
        
        /// 屏幕尺寸
        public enum ScreenSize: Int {
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
            
            /// 是否是全面屏手机
            public var isNewPhone: Bool {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    let ss = Inspire.InLayout.InDevice.screenSize
                    if ss == .iPhone3_5 || ss == .iPhone4_0 || ss == .iPhone4_7 || ss == .iPhone5_5 {
                        return false
                    } else {
                        return true
                    }
                }
                return false
            }
            /// 是否是全面屏iPad
            public var isNewPad: Bool {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    let ss = Inspire.InLayout.InDevice.screenSize
                    if ss == .iPad7_9 || ss == .iPad9_7 || ss == .iPad10_5 || ss == .iPad12_9 {
                        return false
                    } else {
                        return true
                    }
                }
                return false
            }
        }
        
        /// 屏幕尺寸
        public static let screenSize: ScreenSize = {
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
        
        /// 获取当前状态栏高度
        public static let statusBarWindowHeight: CGFloat = {
            return UIApplication.shared.statusBarFrame.size.height
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
    
    /// 获取某个视图控制器的布局安全距离
    /// - Parameter viewController: 视图控制器
    func safeAreaInsets(for viewController: UIViewController) -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return viewController.view.safeAreaInsets
        } else {
            // Fallback on earlier versions
            return Inspire.shared.screen.safeAreaInsets
        }
    }
    
    /// 获取某个视图控制器的顶部栏（状态栏+导航栏）的高度
    /// - Parameter viewController: 视图控制器
    func topBarHeight(for viewController: UIViewController?) -> CGFloat {
        if let nav = viewController as? UINavigationController {
            var h = nav.navigationBar.frame.size.height
            h += safeAreaInsets(for: nav).top
            return h
        } else if let vc = viewController as? UIViewController {
            return safeAreaInsets(for: vc).top + (vc.navigationController?.navigationBar.frame.size.height ?? Inspire.shared.screen.navBar.height)
        } else {
            return 0
        }
    }
    
    /// 获取某个视图控制器的底部栏（Tabbar和底部安全区域）高度
    /// - Parameter viewController: 视图控制器
    func bottomBarHeight(for viewController: UIViewController) -> CGFloat {
        return safeAreaInsets(for: viewController).bottom + (viewController.tabBarController?.tabBar.frame.height ?? Inspire.shared.screen.tabBar.height)
    }
    
}

public extension Inspire {
    typealias InScreen = Inspire.InLayout.InScreen
    typealias InDevice = Inspire.InLayout.InDevice
}


// MARK: - 屏幕布局尺寸常量
public extension Inspire.InLayout.InScreen {
    
    var bounds: CGRect {
        return UIScreen.main.bounds
    }
    var size: CGSize {
        return UIScreen.main.bounds.size
    }
    var width: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    /// 屏幕布局安全区域。
    /// 如果支持横屏，当改变屏幕方向后需要调用 updatedSafeAreaInsets 重新获取
    private static var safeAreaInsets: UIEdgeInsets = {
        return getCurrentSafeAreaInsets()
    }()
    
    /// 屏幕布局安全区域。
    /// 如果支持横屏，当改变屏幕方向后需要调用 updatedSafeAreaInsets 重新获取
    var safeAreaInsets: UIEdgeInsets {
        return Inspire.InLayout.InScreen.safeAreaInsets
    }
    
    /// 获取当前屏幕安全区域
    ///
    /// - Returns: 当前屏幕安全区域
    private static func getCurrentSafeAreaInsets() -> UIEdgeInsets {
        debugPrint("获取当前屏幕安全区域")
        for w in UIApplication.shared.windows {
            if w.isKeyWindow == true, let vc = w.rootViewController {
                if #available(iOS 11.0, *) {
                    print("vc.view.safeAreaInsets: ", vc.view.safeAreaInsets)
                    return vc.view.safeAreaInsets
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        var top = CGFloat(0), left = CGFloat(0), bottom = CGFloat(0), right = CGFloat(0)
        if UIApplication.shared.statusBarOrientation == .portrait {
            top = Inspire.InLayout.InDevice.statusBarWindowHeight
            bottom = Inspire.InLayout.InDevice.bottomSafeAreaHeightOnPortrait
        } else {
            bottom = Inspire.InLayout.InDevice.bottomSafeAreaHeightOnLandscape
            left = Inspire.InLayout.InDevice.statusBarWindowHeight
            right = Inspire.InLayout.InDevice.statusBarWindowHeight
        }
        let inset = UIEdgeInsets.init(top: top, left: left, bottom: bottom, right: right)
        return inset
    }
    
    /// 获取当前状态下的屏幕安全区域，此值会更新至safeAreaInsets。
    /// 一般在屏幕旋转之后调用一次。
    private static var updatedSafeAreaInsets: UIEdgeInsets {
        safeAreaInsets = Inspire.InLayout.InScreen.getCurrentSafeAreaInsets()
        return safeAreaInsets
    }
    
    /// 获取当前状态下的屏幕安全区域，此值会更新至safeAreaInsets。
    /// 一般在屏幕旋转之后调用一次。
    var updatedSafeAreaInsets: UIEdgeInsets {
        return Inspire.InLayout.InScreen.updatedSafeAreaInsets
    }
    
    /// 状态栏尺寸
    var statusBar: CGSize {
        return CGSize.init(width: width, height: safeAreaInsets.top)
    }
    
    /// 导航栏尺寸（不含状态栏）
    var navBar: CGSize {
        return CGSize.init(width: width, height: 44)
    }
    
    /// 状态栏+导航栏区域尺寸
    var topBar: CGSize {
        return CGSize.init(width: width, height: safeAreaInsets.top + navBar.height)
    }
    
    /// TabBar尺寸
    var tabBar: CGSize {
        return CGSize.init(width: width, height: 49)
    }
    
    /// TabBar+底部安全区域尺寸
    var bottomBar: CGSize {
        return CGSize.init(width: width, height: safeAreaInsets.bottom + tabBar.height)
    }
    
    
}
