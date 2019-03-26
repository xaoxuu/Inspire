//
//  Inspire.swift
//  Inspire
//
//  Created by xaoxuu on 2019/3/26.
//  Copyright © 2019 Titan Studio. All rights reserved.
//

import UIKit

struct Inspire {

    public static let current = Inspire()
    
    public struct InColor {
        public var theme = UIColor.init(hex: "#FF9898")
        public var accent = UIColor.init(hex: "#1BCBFA")
        public var background = UIColor.init(hex: "#EFEFEF")
        
    }
    public struct InFont {
        public var title = "ChalkboardSE-Regular"
        public var body = "ChalkboardSE-Regular"
        public var number = "ChalkboardSE-Regular"
    }
    
    
    public var color = InColor()
    public var font = InFont()
    public var layout = InLayout()
    
    init() {
        
    }
    init(dictionary: [String: [String: String]]) {
        if let dict = dictionary["Color"] {
            if let str = dict["theme"] {
                color.theme = UIColor.init(hex: str)
            }
            if let str = dict["accent"] {
                color.accent = UIColor.init(hex: str)
            }
            if let str = dict["background"] {
                color.background = UIColor.init(hex: str)
            }
        }
        if let dict = dictionary["Font"] {
            if let str = dict["title"] {
                font.title = str
            }
            if let str = dict["title"] {
                font.body = str
            }
            if let str = dict["title"] {
                font.number = str
            }
        }
        if let dict = dictionary["Layout"] {
            if let str = dict["padding"] {
                if let d = Double(str) {
                    layout.padding = CGFloat(d)
                }
            }
            if let str = dict["margin"] {
                if let d = Double(str) {
                    layout.margin = CGFloat(d)
                }
            }
            if let str = dict["cornerRadius.large"] {
                if let d = Double(str) {
                    layout.cornerRadius.large = CGFloat(d)
                }
            }
            if let str = dict["cornerRadius.medium"] {
                if let d = Double(str) {
                    layout.cornerRadius.medium = CGFloat(d)
                }
            }
            if let str = dict["cornerRadius.regular"] {
                if let d = Double(str) {
                    layout.cornerRadius.regular = CGFloat(d)
                }
            }
            if let str = dict["cornerRadius.small"] {
                if let d = Double(str) {
                    layout.cornerRadius.small = CGFloat(d)
                }
            }
        }
        
    }
    
}
