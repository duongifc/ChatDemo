//
//  ChatService.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import RxSwift

/**
 A service use for chat api integration
 */
protocol ChatService {
    
    ///An observable uses to receive an message `ChatModel` after analyzing data from the api
    var onReceivedMessage: Observable<ChatModel> { get }
    
    /**
     This method use to send an message
     
     - Parameter
     message: given message
     
     - Returns:
     `Observable<Bool>`:  the status of sending message action
     */
    func send(message: String) -> Observable<Bool>
    
    /**
     This method use to receive messages. After receiving an message, an event will be emitted, subscribe `onReceivedMessage` observable to get new message.
     */
    func receive() -> Observable<Void>
}
