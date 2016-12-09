//
//  ChatServiceImpl.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import RxSwift

/**
 Implement logic code from `ChatService` protocol
 */
class ChatServiceImpl: ChatService {
    
    //MARK: Properties
    private let chatApi: ChatApi!
    private let transformer: ChatMessageTransformer!
    private let receiveMessageSubject = PublishSubject<ChatModel>()
    
    var onReceivedMessage: Observable<ChatModel> {
        return receiveMessageSubject.asObservable()
    }
    
    
    //MARK: Init
    init(chatApi: ChatApi,
         transformer: ChatMessageTransformer) {
        self.chatApi = chatApi
        self.transformer = transformer
    }
    
    //MARK: Messages:
    /**
     This method use to send an message
     
     - Parameter
     message: given message
     
     - Returns:
     `Observable<Bool>`:  the status of sending message action
     */
    func send(message: String) -> Observable<Bool> {
        return chatApi.send(message: message)
            .map({[unowned self] json -> Bool in
                if let chatModel = self.transformer.parse(messageJSON: json, isMine: true) {
                    self.receiveMessageSubject.onNext(chatModel)
                    return true
                }
                
                return false
            })
    }
    
    /**
     This method use to receive messages. After receiving an message, an event will be emitted, subscribe `onReceivedMessage` observable to get new message.
     */
    func receive() -> Observable<Void> {
        return chatApi.receive().map({[unowned self] json -> Void in
            if let chatModel = self.transformer.parse(messageJSON: json, isMine: false) {
                self.receiveMessageSubject.onNext(chatModel)
            }
        })
    }
}
