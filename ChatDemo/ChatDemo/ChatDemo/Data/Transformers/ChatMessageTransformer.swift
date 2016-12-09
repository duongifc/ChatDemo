//
//  ChatMessageTransformer.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation

/**
 Chat message parser
 */
protocol ChatMessageTransformer {
    /**
     Parse json message to chat model object
     
     - Parameter: 
        messageJSON: JSON object
        isMine: **true** if you send a message, **false** if you receive a message
     
     - Returns:
     `ChatModel`: chat object or **nil**
     */
    func parse(messageJSON: [String: AnyObject], isMine: Bool) -> ChatModel?
}
