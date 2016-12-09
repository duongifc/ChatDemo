//
//  ChatServiceMock.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/9/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import XCTest
import RxSwift

@testable import ChatDemo

class ChatServiceMock: ChatService {
    
    static var mockMessage: ChatModel?
    
    private let receiveMessageSubject = PublishSubject<ChatModel>()
    
    var onReceivedMessage: Observable<ChatModel> {
        return receiveMessageSubject.asObservable()
    }
    
    func send(message: String) -> Observable<Bool> {
        if message.characters.count > 0 {
            if let id = ChatServiceMock.mockMessage?.id,
                let time = ChatServiceMock.mockMessage?.time,
                let isMine = ChatServiceMock.mockMessage?.isMine {
                let chatModel = ChatModel(id: id, message: message, time: time, isMine: isMine)
                receiveMessageSubject.onNext(chatModel)
                return Observable.just(false)
            }
            
            return Observable.just(true)
        }
        return Observable.just(false)
    }
    
    func receive() -> Observable<Void> {
        return Observable.create {[weak self] (observer) -> Disposable in

            if let message = ChatServiceMock.mockMessage {
                self?.receiveMessageSubject.onNext(message)
            }
            observer.onNext()
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}
