//
//  InWindow.swift
//  Inspire
//
//  Created by xaoxuu on 2021/7/20.
//  Copyright © 2021 xaoxuu.com. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
public extension UIWindowScene {
    
    /// 当前的 WindowScene
    static var currentWindowScene: UIWindowScene? {
        UIApplication.shared.connectedScenes.first { scene in
            guard let ws = scene as? UIWindowScene else { return false }
            return ws.activationState == .foregroundActive
        } as? UIWindowScene
    }
    
}

public extension UIViewController {
    
    /// 当前 window 的根控制器
    static var currentRootViewController: UIViewController? {
        if #available(iOS 13.0, *) {
            return UIWindowScene.currentWindowScene?.windows.first?.rootViewController
        } else {
            return UIApplication.shared.windows.first { window in
                window.isHidden == false && window.frame == UIScreen.main.bounds
            }?.rootViewController
        }
    }
    
}
