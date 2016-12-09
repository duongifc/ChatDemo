//
//  ChatDemoUITests.swift
//  ChatDemoUITests
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import XCTest

class ChatDemoUITests: XCTestCase {
    
    private var application: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        application = XCUIApplication()
        application.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSendMessage() {
        //Setup
        let message = "This is Duong"
        let textView = application.textViews.element(boundBy: 0)
        
        //Action
        textView.tap()
        textView.typeText(message)
        application.buttons.element(boundBy: 1).tap()
        
        let cells = application.collectionViews.element(boundBy: 0).cells
        let lastCell = cells.element(boundBy: cells.count - 1).staticTexts
        XCTAssertTrue(lastCell[message].exists)
    }
    
    func testReceiveMessage() {
        //Setup
        let button = application.buttons.element(boundBy: 0)
        
        //Action
        button.tap()
        
        let cells = application.collectionViews.element(boundBy: 0).cells
        let lastCell = cells.element(boundBy: cells.count - 1).staticTexts
        
        let predicate = NSPredicate(format: "label BEGINSWITH 'Message Id:'")
        let element = lastCell.element(matching: predicate)
        XCTAssert(element.exists)
    }
}
