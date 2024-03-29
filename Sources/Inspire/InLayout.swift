//
//  LayoutUtil.swift
//  Inspire
//
//  Created by xaoxuu on 2019/3/26.
//  Copyright © 2019 xaoxuu.com. All rights reserved.
//

import UIKit

// MARK: - 设备布局常量
public extension Inspire.InLayout {
    
    /// 设备常量
    struct InDevice {
        
        /// 屏幕尺寸
        public enum ScreenSize: Int {
            case unknown
            case iPhone_Legacy_3_5
            case iPhone_Legacy_4_0
            case iPhone_Legacy_4_7
            case iPhone_Legacy_5_5
            case iPhone_New_5_8 // iPhone X
            case iPhone_New_6_1 // iPhone XR | 11
            case iPhone_New_6_5 // iPhone XS Max、11 Pro Max
            case iPhone_New_5_4 // iPhone 12 mini | 13 mini
            case iPhone_New_6_1_G2 // iPhone 12、12 Pro、13、13 Pro、14
            case iPhone_New_6_7 // 12 Pro Max、13 Pro Max、14 Plus
            case iPhone_New_6_1_G3 // 14 Pro
            case iPhone_New_6_7_G2 // 14 Pro Max
            case iPad_Legacy_7_9
            case iPad_Legacy_9_7
            case iPad_Legacy_10_2
            case iPad_Legacy_10_5
            case iPad_New_7_9 // mini 6
            case iPad_New_10_9 // Air 5
            case iPad_New_11 // iPad Pro 11
            case iPad_New_12_9 // iPad Pro 12.9
            
            /// 是否是全面屏手机
            public var isNewPhone: Bool {
                if UIDevice.current.userInterfaceIdiom == .phone {
                    let ss = Inspire.InLayout.InDevice.screenSize
                    if ss == .iPhone_Legacy_3_5 || ss == .iPhone_Legacy_4_0 || ss == .iPhone_Legacy_4_7 || ss == .iPhone_Legacy_5_5 {
                        return false
                    } else {
                        // 新推出的新尺寸的全面屏iPhone
                        return true
                    }
                }
                return false
            }
            /// 是否是全面屏iPad
            public var isNewPad: Bool {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    let ss = Inspire.InLayout.InDevice.screenSize
                    if ss == .iPad_Legacy_7_9 || ss == .iPad_Legacy_9_7 || ss == .iPad_Legacy_10_5 || ss == .iPad_New_12_9 {
                        return false
                    } else {
                        // 新推出的新尺寸的全面屏iPad
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
                        return ScreenSize.iPad_Legacy_7_9
                    case CGSize(width: 1536, height: 2048):
                        return ScreenSize.iPad_Legacy_9_7
                    case CGSize(width: 1620, height: 2160):
                        return ScreenSize.iPad_Legacy_10_2
                    case CGSize(width: 1668, height: 2224):
                        return ScreenSize.iPad_Legacy_10_5
                    case CGSize(width: 1488, height: 2266):
                        return ScreenSize.iPad_New_7_9
                    case CGSize(width: 1640, height: 2360):
                        return ScreenSize.iPad_New_10_9
                    case CGSize(width: 1668, height: 2388):
                        return ScreenSize.iPad_New_11
                    case CGSize(width: 2048, height: 2732):
                        return ScreenSize.iPad_New_12_9
                    default:
                        break
                    }
                }
                // 尚未兼容的新尺寸的iPad默认被认为是11寸
                return ScreenSize.iPad_New_11
            } else if UIDevice.current.userInterfaceIdiom == .phone {
                if let s = UIScreen.main.currentMode?.size {
                    switch s {
                    case CGSize(width: 320, height: 480), CGSize(width: 640, height: 960):
                        return ScreenSize.iPhone_Legacy_3_5
                    case CGSize(width: 640, height: 1136):
                        return ScreenSize.iPhone_Legacy_4_0
                    case CGSize(width: 750, height: 1334):
                        return ScreenSize.iPhone_Legacy_4_7
                    case CGSize(width: 1242, height: 2208):
                        return ScreenSize.iPhone_Legacy_5_5
                    case CGSize(width: 1125, height: 2436):
                        return ScreenSize.iPhone_New_5_8
                    case CGSize(width: 828, height: 1792):
                        return ScreenSize.iPhone_New_6_1
                    case CGSize(width: 1242, height: 2688):
                        return ScreenSize.iPhone_New_6_5
                    case CGSize(width: 1080, height: 2340):
                        return ScreenSize.iPhone_New_5_4
                    case CGSize(width: 1170, height: 2532):
                        return ScreenSize.iPhone_New_6_1_G2
                    case CGSize(width: 1284, height: 2778):
                        return ScreenSize.iPhone_New_6_7
                    case CGSize(width: 1179, height: 2556):
                        return ScreenSize.iPhone_New_6_1_G3
                    case CGSize(width: 1290, height: 2796):
                        return ScreenSize.iPhone_New_6_7_G2
                    default:
                        break
                    }
                } else {
                    // 尚未兼容的新尺寸的iPhone默认被认为是6.1寸
                    return ScreenSize.iPhone_New_6_1_G2
                }
            }
            // 暂不支持 iPhone、iPad 以外的设备
            return ScreenSize.unknown
        }()
        
        /// 获取当前状态栏高度
        public static var statusBarWindowHeight: CGFloat {
            if #available(iOS 13.0, *) {
                return ipr.windowScene?.statusBarManager?.statusBarFrame.height ?? .zero
            } else {
                return UIApplication.shared.statusBarFrame.size.height
            }
        }
        
        
        /// 竖屏时底部的安全区域高度
        public static let bottomSafeAreaHeightOnPortrait: CGFloat = {
            if screenSize.isNewPhone {
                return 34
            } else if screenSize == .iPad_New_11 {
                return 21
            }
            return 0
        }()
        
        /// 横屏时底部的安全区域高度
        public static let bottomSafeAreaHeightOnLandscape: CGFloat = {
            if screenSize.isNewPhone || screenSize.isNewPad {
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
        } else if let vc = viewController {
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


// MARK: - 窗口布局尺寸常量
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
    
    /// 根控制器的屏幕布局安全区域
    var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            if let rootVC = Inspire.shared.rootVC {
                return rootVC.view.safeAreaInsets
            } else {
                // 拿不到根控制器，在 Inspire.shared.rootVC 里已经抛出了警告
                return .zero
            }
        } else {
            // iOS 11 以下的版本不存在 safeAreaInsets
            return .zero
        }
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
