//
//  ChatApi.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import RxSwift

/**
 Chat Api
 */
protocol ChatApi {
    /**
     This method returns json message which contains chat information from the api after sending message successfully
     
     - Parameter
     message: The message that user typed
     
     - Returns:
     `Observable<[String: AnyObject]>`:  message JSON
     */
    func send(message: String) -> Observable<[String: AnyObject]>
    
    /**
     This method returns json message which contains chat information from the api when other users send you an message
     
     - Returns:
     `Observable<[String: AnyObject]>`:  message JSON
     */
    func receive() -> Observable<[String: AnyObject]>
}
