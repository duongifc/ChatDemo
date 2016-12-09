//
//  ChatMessageTransformerMock.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
@testable import ChatDemo

class ChatMessageTransformerMock: ChatMessageTransformer {
    
    static var chatModel: ChatModel? = ChatModel(id: "12345", message: "Message from mock transformer", time: 123123, isMine: true)
    
    func parse(messageJSON: [String : AnyObject], isMine: Bool) -> ChatModel? {
        return ChatMessageTransformerMock.chatModel
    }
}
