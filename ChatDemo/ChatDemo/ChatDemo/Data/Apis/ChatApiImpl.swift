//
//  ChatApiImpl.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import RxSwift

/**
 Implement logic code from `ChatApi` protocol
 */
class ChatApiImpl: ChatApi {
    
}

extension ChatApiImpl {
    /**
     This method returns json message which contains chat information from the api after sending message successfully
     
     - Parameter
        message: The message that user typed
     
     - Returns: 
        `Observable<[String: AnyObject]>`:  message JSON
     */
    func send(message: String) -> Observable<[String: AnyObject]> {
        return Observable.create { (observer) -> Disposable in
            let currentDate = Date()
            let time = currentDate.getMiliSecond()
            let chatId = String(time)
            
            let json = ["code": 200, "message": ["id": chatId, "message": message, "time": time]] as [String : Any]
            observer.onNext(json as [String : AnyObject])
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    /**
     This method returns json message which contains chat information from the api when other users send you an message
     
     - Returns:
     `Observable<[String: AnyObject]>`:  message JSON
     */
    func receive() -> Observable<[String: AnyObject]> {
        return Observable.create { (observer) -> Disposable in
            
            let currentDate = Date()
            let time = currentDate.getMiliSecond()
            let chatId = String(time)
            
            let json = ["code": 200, "message": ["id": chatId, "message": "Message Id: " + chatId, "time": time]] as [String : Any]
            
            observer.onNext(json as [String : AnyObject])
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}
