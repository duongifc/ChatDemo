//
//  Components.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
class Components {
    
    static let instance = Components()
    
    //MARK: Chat api
    
    private lazy var internalChatApi : ChatApi = {
        return ChatApiImpl()
    }()
    
    //MARK: Chat message transformer
    /// It parses json to chat model object
    static var chatMessageTransformer: ChatMessageTransformer {
        return instance.internalChatMessageTransformer
    }
    
    private lazy var internalChatMessageTransformer : ChatMessageTransformer = {
        return ChatMessageTransformerImpl()
    }()
    
    //MARK: Chat service
    ///It uses for api integration, analyzing data from api
    static var chatService: ChatService {
        return instance.internalChatService
    }
    
    private lazy var internalChatService : ChatService = {
        return ChatServiceImpl(chatApi: instance.internalChatApi,
                               transformer: instance.internalChatMessageTransformer)
    }()
}
