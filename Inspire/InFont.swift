//
//  Font.swift
//  Inspire
//
//  Created by xaoxuu on 2019/3/26.
//  Copyright © 2019 Titan Studio. All rights reserved.
//

import UIKit

public extension UIFont {
    
    internal class func getFontName(_ style: Inspire.InFont.Style = .body) -> String {
        let font = Inspire.current.font
        switch style {
        case .title:
            return font.title
        case .body:
            return font.body
        case .number:
            return font.number
        case .code:
            return font.code
        }
    }
    
    public class func regular(_ size: CGFloat, for style: Inspire.InFont.Style = .body) -> UIFont {
        let desc = UIFontDescriptor.init(fontAttributes: [.name : getFontName(style)])
        return UIFont.init(descriptor: desc, size: size)
    }
    
    public class func bold(_ size: CGFloat, for style: Inspire.InFont.Style = .body) -> UIFont {
        return regular(size, for: style).boldFont()
    }
    
    public func boldFont() -> UIFont {
        let fontDesc = fontDescriptor
        let fontDescriptorSymbolicTraits = UIFontDescriptor.SymbolicTraits.init(rawValue:(fontDesc.symbolicTraits.rawValue | UIFontDescriptor.SymbolicTraits.traitBold.rawValue))
        let boldFontDesc = fontDesc.withSymbolicTraits(fontDescriptorSymbolicTraits)
        return UIFont.init(descriptor: boldFontDesc!, size: pointSize)
    }
    
}

