//
//  PlaceholderTextView.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation

/**
 A control customs text view to set place holder
 */
class PlaceholderTextView: UITextView {
    
    fileprivate weak var textViewDelegate: UITextViewDelegate?
    private var placeholderText: String = ""
    private var placeholderColor: UIColor = UIColor.lightGray
    fileprivate var placeholderLabel: UILabel = UILabel()
    
    /**
     Implment logic code for preparing data before rendering
     */
    override func awakeFromNib() {
        textViewDelegate = delegate
        addSubview(placeholderLabel)
        placeholderLabel.isUserInteractionEnabled = false
        
        delegate = self
    }
    
    /**
     Read `layoutSubviews` from Apple documentation
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        placeholderLabel.frame = CGRect(x: 5, y: 0, width: frame.width, height: frame.height)
    }
    
    
    // MARK: TextView Helper
    /**
     Clear text and hide place holder label
     */
    func clear() {
        text = ""
        placeholderLabel.isHidden = false
    }
    
    /**
     Set place holder string and show place holder label, apply attributes
     */
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
}

// MARK: UITextViewDelegate
extension PlaceholderTextView: UITextViewDelegate {
    /**
     Delegate to `textViewDidChange` method if textview is already set delegate
     */
    func textViewDidChange(_ textView: UITextView) {
        if textViewDelegate?
            .responds(to: #selector(UITextViewDelegate.textViewDidChange)) == true {
            placeholderLabel.isHidden = !textView.text.isEmpty
            textViewDelegate?.textViewDidChange!(textView)
        }
    }
}
