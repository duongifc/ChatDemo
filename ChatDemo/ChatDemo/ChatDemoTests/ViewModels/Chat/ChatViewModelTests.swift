//
//  ChatViewModelTests.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import UIKit
import XCTest
import RxSwift

@testable import ChatDemo

class ChatViewModelTests: XCTestCase {
    
    private var chatServiceMock: ChatService!
    private var viewModel: ChatViewModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        chatServiceMock = ChatServiceMock()
        viewModel = ChatViewModel(chatService: chatServiceMock)
    }
    
    func testSendMessageSuccessful() {
        //Setup
        let message = "Message"
        let expectedResult = ChatModel(id: "12345", message: message, time: 123123, isMine: true)
        ChatServiceMock.mockMessage = expectedResult
        
        //Action
        var result: ChatModel?
        _ = viewModel.onReceivedMessage.subscribe(onNext: { (message) in
                result = message
            }, onError: { (error) in
                
            }, onCompleted: { 
                
            }, onDisposed: { 
                
            })
        viewModel.sendMessage(message: message)
        
        //Assert
        XCTAssertEqual(expectedResult.id, result?.id)
        XCTAssertEqual(expectedResult.message, result?.message)
        XCTAssertEqual(expectedResult.time, result?.time)
        XCTAssertEqual(expectedResult.isMine, result?.isMine)
    }
    
    func testSendMessageFail() {
        //Setup
        let message = "Message"
        let expectedResult = ChatModel(id: "12345", message: message, time: 123123, isMine: true)
        ChatServiceMock.mockMessage = nil
        
        //Action
        var result: ChatModel?
        _ = viewModel.onReceivedMessage.subscribe(onNext: { (message) in
            result = message
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }, onDisposed: {
                
        })
        viewModel.sendMessage(message: message)
        
        //Assert
        XCTAssertNotEqual(expectedResult.id, result?.id)
        XCTAssertNotEqual(expectedResult.message, result?.message)
        XCTAssertNotEqual(expectedResult.time, result?.time)
        XCTAssertNotEqual(expectedResult.isMine, result?.isMine)
    }
    
    func testReceiveMessageSuccessful() {
        //Setup
        let message = "Message"
        let expectedResult = ChatModel(id: "12345", message: message, time: 123123, isMine: true)
        
        //Action
        var result: ChatModel?
        _ = viewModel.onReceivedMessage.subscribe(onNext: { (message) in
            result = message
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }, onDisposed: {
                
        })
        ChatServiceMock.mockMessage = expectedResult
        viewModel.receiveMessage()
        
        //Assert
        XCTAssertEqual(expectedResult.id, result?.id)
        XCTAssertEqual(expectedResult.message, result?.message)
        XCTAssertEqual(expectedResult.time, result?.time)
        XCTAssertEqual(expectedResult.isMine, result?.isMine)
    }
    
    func testReceiveMessageFail() {
        //Setup
        let message = "Message"
        let expectedResult = ChatModel(id: "12345", message: message, time: 123123, isMine: true)
        
        //Action
        var result: ChatModel?
        _ = viewModel.onReceivedMessage.subscribe(onNext: { (message) in
            result = message
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }, onDisposed: {
                
        })
        viewModel.receiveMessage()
        
        //Assert
        XCTAssertNotEqual(expectedResult.id, result?.id)
        XCTAssertNotEqual(expectedResult.message, result?.message)
        XCTAssertNotEqual(expectedResult.time, result?.time)
        XCTAssertNotEqual(expectedResult.isMine, result?.isMine)
    }
    
    func testCheckValidMessageFail() {
        //Setup 
        let message = ""
        let expectedResult = false
        
        //Action
        var result = true
        _ = viewModel.onEnableSendButton.subscribe(onNext: { (enable) in
                result = enable
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }, onDisposed: {
        })
        viewModel.checkValid(message: message)
        
        //Assert
        XCTAssertEqual(expectedResult, result)
    }
    
    func testCheckValidMessageSuccessful() {
        //Setup
        let message = "message"
        let expectedResult = true
        
        //Action
        var result = false
        _ = viewModel.onEnableSendButton.subscribe(onNext: { (enable) in
                result = enable
            }, onError: { (error) in
                
            }, onCompleted: {
                
            }, onDisposed: {
        })
        viewModel.checkValid(message: message)
        
        //Assert
        XCTAssertEqual(expectedResult, result)
    }
}
