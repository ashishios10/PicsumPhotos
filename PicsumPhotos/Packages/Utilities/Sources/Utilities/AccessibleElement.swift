//
//  AccessibleElement.swift
//  
//
//  Created by Ashish Patel on 1/21/23.
//

import UIKit

public protocol AccessibleElement {
    func addAccessibility(description: String, hint: String?)
    func addAccessibility(traits: UIAccessibilityTraits)
}

extension AccessibleElement where Self : UIResponder {
    public func addAccessibility(description: String, hint: String?) {
        self.accessibilityLabel = description
        self.accessibilityHint = hint
        self.isAccessibilityElement = true
    }
    
    public func addAccessibility(traits: UIAccessibilityTraits = UIAccessibilityTraits.none) {
        self.accessibilityTraits = traits
    }
}
