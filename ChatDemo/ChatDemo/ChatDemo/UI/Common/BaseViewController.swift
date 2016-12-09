//
//  BaseViewController.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

/**
 Parent class of `UIViewController`
 */
class BaseViewController: UIViewController {
    /**
     Thread safe bag that disposes added disposables on `deinit`.
     
     This returns ARC (RAII) like resource management to `RxSwift`.
     
     In case contained disposables need to be disposed, just put a different dispose bag
     or create a new one in its place.
     
     self.existingDisposeBag = DisposeBag()
     
     In case explicit disposal is necessary, there is also `CompositeDisposable`.
     
     */
    var disposeBag = DisposeBag()
    
    /**
     Hide keyboard and stop editing
     */
    func hideKeyboard() {
        view.endEditing(true)
    }
}
