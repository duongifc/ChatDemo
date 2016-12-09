//
//  ChatModel.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation

/**
 Use for store chat information.
 */
class ChatModel {
    ///Chat id which is unique
    let id: String
    ///Content of message
    let message: String
    ///Created time of message
    let time: Int64
    ///It uses for rendering message box (left or right)
    let isMine: Bool
    init(id: String, message: String, time: Int64, isMine: Bool) {
        self.id = id
        self.message = message
        self.time = time
        self.isMine = isMine
    }
}
