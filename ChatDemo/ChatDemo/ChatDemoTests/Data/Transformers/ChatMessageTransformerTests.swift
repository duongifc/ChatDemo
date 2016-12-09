//
//  ChatMessageTransformerTest.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import XCTest

@testable import ChatDemo

class ChatMessageTransformerTests: XCTestCase {
    
    private var transformer: ChatMessageTransformer!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        transformer = Components.chatMessageTransformer
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseSuccessful() {
        
        //Setup
        let currentDate = Date()
        let time = currentDate.getMiliSecond()
        let chatId = String(time)
        let message = "This is a message"
        let isMine = true
        let inputJSON = ["code": 200, "message": ["id": chatId, "message": message, "time": time]] as [String : Any]
        
        //Action
        let outputChatModel = transformer.parse(messageJSON: inputJSON as [String : AnyObject], isMine: isMine)
        
        //Assert
        XCTAssertEqual(chatId, outputChatModel?.id)
        XCTAssertEqual(message, outputChatModel?.message)
        XCTAssertEqual(time, outputChatModel?.time)
        XCTAssertEqual(isMine, outputChatModel?.isMine)
    }
    
    func testParseFail() {
        
        //Setup
        let currentDate = Date()
        let time = currentDate.getMiliSecond()
        let chatId = String(time)
        let message = "This is a message"
        let isMine = true
        let inputJSON = ["code": 200, "message": ["id": chatId, "message": message, "time": time]] as [String : Any]
        
        //Action
        let outputChatModel = transformer.parse(messageJSON: inputJSON as [String : AnyObject], isMine: isMine)
        
        //Assert
        XCTAssertNotEqual(chatId + "123", outputChatModel?.id)
        XCTAssertNotEqual(message + "123", outputChatModel?.message)
        XCTAssertNotEqual(time + 1, outputChatModel?.time)
        XCTAssertNotEqual(!isMine, outputChatModel?.isMine)
    }
    
}
