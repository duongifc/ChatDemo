//
//  PlaceholderTextView.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation

class PlaceholderTextView: UITextView {
    
    fileprivate weak var textViewDelegate: UITextViewDelegate?
    private var placeholderText: String = ""
    private var placeholderColor: UIColor = UIColor.lightGray
    fileprivate var placeholderLabel: UILabel = UILabel()
    
    override func awakeFromNib() {
        textViewDelegate = delegate
        addSubview(placeholderLabel)
        placeholderLabel.isUserInteractionEnabled = false
        
        delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.frame = CGRect(x: 5, y: 0, width: frame.width, height: frame.height)
    }
    
    ////////////////////////////////////////////////////////////////////////////
    
    
    // MARK: TextView Helper
    ////////////////////////////////////////////////////////////////////////////
    
    func clear() {
        text = ""
        placeholderLabel.isHidden = false
    }
    
    func applyPlaceholderStyle(placeholderText: String, placeholderColor: UIColor? = nil) {
        // make it look (initially) like a placeholder
        if let color = placeholderColor {
            self.placeholderColor = color
        }
        self.placeholderText = placeholderText
        
        placeholderLabel.text = self.placeholderText
        placeholderLabel.textColor = self.placeholderColor
        placeholderLabel.font = font
    }
    
    ////////////////////////////////////////////////////////////////////////////
    
}

////////////////////////////////////////////////////////////////////////////


// MARK: UITextViewDelegate
////////////////////////////////////////////////////////////////////////////

extension PlaceholderTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textViewDelegate?
            .responds(to: #selector(UITextViewDelegate.textViewDidChange)) == true {
            placeholderLabel.isHidden = !textView.text.isEmpty
            textViewDelegate?.textViewDidChange!(textView)
        }
    }
}
