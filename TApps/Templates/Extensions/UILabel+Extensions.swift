//
//  UILabel+Extensions.swift
//  wtp
//
//  Created by muhammadjon on 12/11/2019.
//  Copyright © 2019 MuhammadjonTohirov. All rights reserved.
//

import UIKit

extension UILabel {
    ///
    open func getEstimatedSize(_ width: CGFloat = CGFloat.greatestFiniteMagnitude, height: CGFloat = CGFloat.greatestFiniteMagnitude) -> CGSize {
        return sizeThatFits(CGSize(width: width, height: height))
    }
    
    ///
    open func getEstimatedHeight() -> CGFloat {
        return sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)).height
    }
    
    ///
    open func getEstimatedWidth() -> CGFloat {
        return sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)).width
    }
    
    ///
    open func fitHeight() {
        self.height = getEstimatedHeight()
    }
    
    ///
    open func fitWidth() {
        self.width = getEstimatedWidth()
    }
    
    ///
    open func fitSize() {
        self.fitWidth()
        self.fitHeight()
        sizeToFit()
    }
}

extension UILabel {
    /// Set spacing size between lines
    ///
    /// Example: let label = UILabel()
    ///     label.numberOfLines = 2
    ///     label.text = "line1 \n line2"
    ///     label.setLineSpacingHeight(10)
    ///  result: spacing size between line1 and line2 will be CGFloat(10)
    
    open func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        
        // (Swift 4.1 and 4.0) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
    
    open func setLineSpacingHeight(_ lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                         value: style,
                                         range: NSRange(location: 0, length: text.count))
            self.attributedText = attributeString
        }
    }
    
    open func textHeight(_ width: CGFloat) -> CGFloat {
        return self.text?.heightWithConstrainedWidth(width: width, font: self.font) ?? 0
    }
}

