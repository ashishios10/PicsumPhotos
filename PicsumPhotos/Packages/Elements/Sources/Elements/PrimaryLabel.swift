//
//  File.swift
//  
//
//  Created by Ashish Patel on 1/15/23.
//

import UIKit
import Utilities

@IBDesignable
public class PrimaryLabel: UILabel, AccessibleElement {
    
    public override var text: String? {
        didSet {
            if let text = text {
                addAccessibility(description: text, hint: text)
            }
        }
    }
    
    public func setDynamicCustomFont( type: fontType, size: AppFontSize) {
        let customFont = UIFont.setFont(type, size: size)
        adjustsFontForContentSizeCategory = true
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: customFont)
    }
}
