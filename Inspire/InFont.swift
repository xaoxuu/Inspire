//
//  Font.swift
//  Inspire
//
//  Created by xaoxuu on 2019/3/26.
//  Copyright © 2019 Titan Studio. All rights reserved.
//

import UIKit

public extension UIFont {
    
    internal class func getFontName(_ style: Inspire.InFont.Scheme = .body) -> String {
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
    
    class func regular(_ size: CGFloat, for style: Inspire.InFont.Scheme = .body) -> UIFont {
        let desc = UIFontDescriptor.init(fontAttributes: [.name : getFontName(style)])
        return UIFont.init(descriptor: desc, size: size)
    }
    
    class func bold(_ size: CGFloat, for style: Inspire.InFont.Scheme = .body) -> UIFont {
        return regular(size, for: style).boldFont()
    }
    
    func boldFont() -> UIFont {
        let fontDesc = fontDescriptor
        let fontDescriptorSymbolicTraits = UIFontDescriptor.SymbolicTraits.init(rawValue:(fontDesc.symbolicTraits.rawValue | UIFontDescriptor.SymbolicTraits.traitBold.rawValue))
        if let boldFontDesc = fontDesc.withSymbolicTraits(fontDescriptorSymbolicTraits) {
            return UIFont.init(descriptor: boldFontDesc, size: pointSize)
        } else {
            return self
        }
    }
    
}

public extension Inspire {
    
    static func configDefault(font: String, for scheme: Inspire.InFont.Scheme) {
        switch scheme {
        case .title:
            if Inspire.shared.font.title == "" {
                Inspire.shared.font.title = font
            }
        case .body:
            if Inspire.shared.font.body == "" {
                Inspire.shared.font.body = font
            }
        case .number:
            if Inspire.shared.font.number == "" {
                Inspire.shared.font.number = font
            }
        case .code:
            if Inspire.shared.font.code == "" {
                Inspire.shared.font.code = font
            }
        }
    }
    
}
