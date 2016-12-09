//
//  ChatApi.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import RxSwift

protocol ChatApi {
    func send(message: String) -> Observable<[String: AnyObject]>
    func receive() -> Observable<[String: AnyObject]>
}
