//
//  RightTextMessageCell.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import UIKit
/**
 This uses to render partner message box
 */
class RightTextMessageCell: UICollectionViewCell {

    @IBOutlet private weak var constraintImageViewAvatarWidth: NSLayoutConstraint!
    @IBOutlet private weak var containerView: UIView!{
        didSet {
            containerView.layer.cornerRadius = 10
            containerView.layer.masksToBounds = true
        }
    }
    @IBOutlet private weak var imageViewAvatar: UIImageView! {
        didSet {
            styleAvatar(imageView: imageViewAvatar)
        }
    }
    @IBOutlet private weak var labelMessage: UILabel! {
        didSet {
            labelMessage.textAlignment = .right
        }
    }
    
    /**
     Implment logic code for preparing data before rendering
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        labelMessage.preferredMaxLayoutWidth = UIScreen.main.bounds.width - constraintImageViewAvatarWidth.constant * 2 - 16
    }
    
    /**
     Bind and show data with given `ChatModel`
     
     - Paramater:
     chatModel: given chat model
     */
    func bind(chatModel: ChatModel) {
        labelMessage.text = chatModel.message
    }
    
    private func styleAvatar(imageView: UIImageView) {
        imageView.layer.cornerRadius = constraintImageViewAvatarWidth.constant / 2
        imageView.layer.masksToBounds = true
    }
}
