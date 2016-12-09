//
//  ChatMessageTransformerImpl.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation

/**
 Implement logic code from `ChatMessageTransformer` protocol
 */
class ChatMessageTransformerImpl: ChatMessageTransformer {
    /**
     Parse json message to chat model object
     
     - Parameter:
     messageJSON: JSON object
     isMine: true if you send a message, false if you receive a message
     
     - Returns:
     `ChatModel`: chat object or `nil`
     */
    func parse(messageJSON: [String: AnyObject], isMine: Bool) -> ChatModel? {
        if let messageObject = messageJSON["message"],
            let id = messageObject["id"] as? String,
            let message = messageObject["message"] as? String,
            let time = messageObject["time"] as? Int64 {
            return ChatModel(id: id,
                             message: message,
                             time: time,
                             isMine: isMine)
        }
    
        return nil
    }
}
