//
//  RxSwiftExtension.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import RxSwift

extension DisposeBag {
    func addDisposables(array: [Disposable]) {
        for item in array {
            insert(item)
        }
    }
}
