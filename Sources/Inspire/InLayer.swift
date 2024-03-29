//
//  InLayer.swift
//  Inspire
//
//  Created by xaoxuu on 2022/6/23.
//  Copyright © 2022 Titan Studio. All rights reserved.
//

import UIKit

public extension CALayer {
    
    /// 切部分圆角
    /// - Parameters:
    ///   - corners: 位置
    ///   - cornerRadii: 半径
    func cornerRadius(corners: UIRectCorner, cornerRadii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadii, height: cornerRadii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.mask = maskLayer
    }
    
    var cornerRadiusWithContinuous: CGFloat {
        get { cornerRadius }
        set {
            cornerRadius = newValue
            if #available(iOS 13.0, *) {
                cornerCurve = .continuous
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
}
