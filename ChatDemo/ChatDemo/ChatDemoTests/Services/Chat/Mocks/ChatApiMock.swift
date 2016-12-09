//
//  ChatApiMock.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import RxSwift

@testable import ChatDemo

class ChatApiMock: ChatApi {
    
    static var mockMessage = ["code": 200, "message": ["id": "12345", "message": "This is a mock message", "time": 1234567]] as [String : Any]
    
    func send(message: String) -> Observable<[String : AnyObject]> {
    
        var jsonObject = ChatApiMock.mockMessage as [String : AnyObject]
        var messageJSON = jsonObject["message"] as! [String : AnyObject]
        messageJSON["message"] = message as AnyObject?
        jsonObject["message"] = messageJSON as AnyObject?
        return Observable.just(jsonObject as [String : AnyObject])
    }
    
    func receive() -> Observable<[String : AnyObject]> {
        let jsonObject = ChatApiMock.mockMessage
        return Observable.just(jsonObject as [String : AnyObject])
    }
}
