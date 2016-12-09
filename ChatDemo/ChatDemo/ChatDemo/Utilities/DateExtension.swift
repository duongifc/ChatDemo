//
//  DateUtil.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation

extension Date {
    
    /**
     Get miliseconds from given date
     */
    func getMiliSecond() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
