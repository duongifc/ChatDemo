//
//  ChatServiceTests.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import XCTest
import RxSwift

@testable import ChatDemo

class ChatServiceTests: XCTestCase {
    
    private var mockApi: ChatApiMock!
    private var chatService: ChatService!
    private var mockTransformer: ChatMessageTransformer!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockApi = ChatApiMock()
        mockTransformer = ChatMessageTransformerMock()
        chatService = ChatServiceImpl(chatApi: mockApi, transformer: mockTransformer)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSendMessageSuccessful() {
        //Setup 
        let expectResult = true
        ChatMessageTransformerMock.chatModel = ChatModel(id: "12345", message: "Message from mock transformer", time: 123123, isMine: true)
        
        //Action
        var result = false
        _ = chatService.send(message: "Duong").subscribe(onNext: { (success) in
                result = success
            }, onError: { (error) in
                
            }, onCompleted: { 
                
            }, onDisposed: {
        })
        
        //Assert
        XCTAssertEqual(expectResult, result)
    }
    
    func testSendMessageFail() {
        //Setup
        ChatMessageTransformerMock.chatModel = nil
        let expectResult = false
        
        //Action
        var result = true
        _ = chatService.send(message: "Duong").subscribe(onNext: { (success) in
            result = success
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }, onDisposed: {
        })
        
        //Assert
        XCTAssertEqual(expectResult, result)
    }
    
    func testReceiveMessageSuccessful() {
        //Setup
        let expectResult = ChatModel(id: "1", message: "Duong 1", time: 12333, isMine: true)
        ChatMessageTransformerMock.chatModel = expectResult
        
        //Action
        var result: ChatModel? = nil
        _ = chatService.onReceivedMessage.subscribe(onNext: { (message) in
                result = message
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }, onDisposed: {
        })
        _ = chatService.receive().subscribe()
        
        //Assert
        XCTAssertEqual(expectResult.id, result?.id)
        XCTAssertEqual(expectResult.message, result?.message)
        XCTAssertEqual(expectResult.time, result?.time)
        XCTAssertEqual(expectResult.isMine, result?.isMine)
    }

    
    func testReceiveMessageFail() {
        //Setup
        let expectResult = ChatModel(id: "1", message: "Duong 1", time: 12333, isMine: true)
        ChatMessageTransformerMock.chatModel = nil
        
        //Action
        var result: ChatModel? = nil
        _ = chatService.onReceivedMessage.subscribe(onNext: { (message) in
                result = message
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }, onDisposed: {
        })
        _ = chatService.receive().subscribe()
        
        //Assert
        XCTAssertNotEqual(expectResult.id, result?.id)
        XCTAssertNotEqual(expectResult.message, result?.message)
        XCTAssertNotEqual(expectResult.time, result?.time)
        XCTAssertNotEqual(expectResult.isMine, result?.isMine)
    }
}
