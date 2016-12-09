//
//  ChatViewModel.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import RxSwift

/**
 View model of chat screen
 */
class ChatViewModel: BaseViewModel {
    
    //MARK: Properties
    ///Default height of text view message
    let defaultTextviewHeight: CGFloat = 31
    private let maximumTextViewHeight: CGFloat = 60
    private var lastTextViewHeight: CGFloat = 0
    
    private let chatService: ChatService
    private let scheduler: SerialDispatchQueueScheduler
    
    private let receiveMessageSubject = PublishSubject<ChatModel>()
    ///Subcribe this observable to receive new message
    var onReceivedMessage: Observable<ChatModel> {
        return receiveMessageSubject.asObserver().subscribeOn(scheduler)
    }
    
    private var shouldUpdateTextViewSizeSubject = PublishSubject<CGFloat>()
    
    ///Subcribe this observable get new height of text view message while typing long text
    var onUpdateTextViewSize: Observable<CGFloat> {
        return shouldUpdateTextViewSizeSubject.asObservable()
    }
    
    private var shouldEnableSendButtonSubject = PublishSubject<Bool>()
    ///Subcribe this observable to enable or disable send button
    var onEnableSendButton: Observable<Bool> {
        return shouldEnableSendButtonSubject.asObservable()
    }
    
    private var shouldClearTextViewMessageSubject = PublishSubject<Void>()
    ///Subcribe this observable to clear text of text view message after sending, deleting
    var onClearTextViewMessage: Observable<Void> {
        return shouldClearTextViewMessageSubject.asObservable()
    }
    
    //MARK: Init
    /**
     Init `ChatViewModel` object
     
     - Parameter:
        chatService: given chat service
     
     */
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
    /**
     This method use to send an message after tapping on send button.
     
     - Parameter
     message: given message from text view message
     */
    func sendMessage(message: String) {
        _ = chatService.send(message: message).subscribe().addDisposableTo(disposeBag)
        shouldClearTextViewMessageSubject.onNext()
        checkValid(message: "")
    }
    
    /**
     This method use to receive messages. After receiving an message, an event will be emitted, subscribe `onReceivedMessage` observable to get new message.
     */
    func receiveMessage() {
        _ = chatService.receive().subscribe().addDisposableTo(disposeBag)
    }
    
    //MARK: Textview message
    /**
     Increase or decrease height of text view message while typing
     
     - Parameter:
        textView: text view message
     */
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
    
    /**
     Check valid message in range
     
     - Remark:
        - Min: 1 character
        - Max: 144 characters
        - If message is valid, send button will be enabled. If no, will be disabled
     
     - Parameter: 
        message: give message
     */
    func checkValid(message: String) {
        let shouldChange = message.characters.count > 0 && message.characters.count < 144
        shouldEnableSendButtonSubject.onNext(shouldChange)
    }
}
