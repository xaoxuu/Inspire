//
//  LayoutUtil.swift
//  Inspire
//
//  Created by xaoxuu on 2019/3/26.
//  Copyright © 2019 Titan Studio. All rights reserved.
//

import UIKit


extension Inspire.InLayout.ScreenSize {
    public var isNewPhone: Bool {
        if UIDevice.current.userInterfaceIdiom == .phone {
            let ss = Inspire.InLayout.DeviceConst.screenSize
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
            let ss = Inspire.InLayout.DeviceConst.screenSize
            if ss == .iPad7_9 || ss == .iPad9_7 || ss == .iPad10_5 || ss == .iPad12_9 {
                return false
            } else {
                return true
            }
        }
        return false
    }
    
}

