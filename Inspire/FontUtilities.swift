//
//  Font.swift
//  Inspire
//
//  Created by xaoxuu on 2019/3/26.
//  Copyright © 2019 Titan Studio. All rights reserved.
//

import UIKit

internal extension UIFont {
    
    class func regular(_ size: CGFloat) -> UIFont? {
        return UIFont.init(name: Inspire.current.font.title, size: size)
    }
    
    class func bold(_ size: CGFloat) -> UIFont? {
        return regular(size)?.boldFont()
    }
    
    
    func boldFont() -> UIFont {
        let fontDesc = fontDescriptor
        let fontDescriptorSymbolicTraits = UIFontDescriptor.SymbolicTraits.init(rawValue:(fontDesc.symbolicTraits.rawValue | UIFontDescriptor.SymbolicTraits.traitBold.rawValue))
        let boldFontDesc = fontDesc.withSymbolicTraits(fontDescriptorSymbolicTraits)
        return UIFont.init(descriptor: boldFontDesc!, size: pointSize)
    }
    
}
