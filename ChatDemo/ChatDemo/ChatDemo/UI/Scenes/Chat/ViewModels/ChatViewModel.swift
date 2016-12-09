//
//  ChatViewModel.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import RxSwift

class ChatViewModel: BaseViewModel {
    
    //MARK: Properties
    let defaultTextviewHeight: CGFloat = 31
    private let maximumTextViewHeight: CGFloat = 60
    private var lastTextViewHeight: CGFloat = 0
    
    private let chatService: ChatService
    private let scheduler: SerialDispatchQueueScheduler
    
    private let receiveMessageSubject = PublishSubject<ChatModel>()
    var onReceivedMessage: Observable<ChatModel> {
        return receiveMessageSubject.asObserver().subscribeOn(scheduler)
    }
    
    private var shouldUpdateTextViewSizeSubject = PublishSubject<CGFloat>()
    var onUpdateTextViewSize: Observable<CGFloat> {
        return shouldUpdateTextViewSizeSubject.asObservable()
    }
    
    private var shouldEnableSendButtonSubject = PublishSubject<Bool>()
    var onEnableSendButton: Observable<Bool> {
        return shouldEnableSendButtonSubject.asObservable()
    }
    
    private var shouldClearTextViewMessageSubject = PublishSubject<Void>()
    var onClearTextViewMessage: Observable<Void> {
        return shouldClearTextViewMessageSubject.asObservable()
    }
    
    //MARK: Init
    init(chatService: ChatService) {
        self.chatService = chatService
        let serialQueue = DispatchQueue(label: "ChatSerialQueue")
        self.scheduler = SerialDispatchQueueScheduler(queue: serialQueue,
                                                      internalSerialQueueName: "ChatViewModelQueue")
        super.init()

        disposeBag.addDisposables(array: [
            chatService.onReceivedMessage.subscribe(onNext: {[weak self] (chatModel) in
                    self?.receiveMessageSubject.onNext(chatModel)
                }, onError: { (error) in
                    
                }, onCompleted: { 
                    
                }, onDisposed: { 
                    
                })
        ])
    }
    
    //MARK: Messages
    func sendMessage(message: String) {
        _ = chatService.send(message: message).subscribe().addDisposableTo(disposeBag)
        shouldClearTextViewMessageSubject.onNext()
        checkValid(message: "")
    }
    
    func receiveMessage() {
        _ = chatService.receive().subscribe().addDisposableTo(disposeBag)
    }
    
    //MARK: Textview message
    func textViewMessageDidChange(textView: UITextView) {
        checkValid(message: textView.text)
        var height = textView.contentSize.height
        if lastTextViewHeight == height {
            return
        } else {
            lastTextViewHeight = height
        }
        if defaultTextviewHeight...maximumTextViewHeight ~= height {
            
        } else if height < defaultTextviewHeight {
            height = defaultTextviewHeight
        }
        else if height > maximumTextViewHeight {
            height = maximumTextViewHeight
        }
        shouldUpdateTextViewSizeSubject.onNext(height + 3)
    }
    
    func checkValid(message: String) {
        let shouldChange = message.characters.count > 0 && message.characters.count < 144
        shouldEnableSendButtonSubject.onNext(shouldChange)
    }
}
