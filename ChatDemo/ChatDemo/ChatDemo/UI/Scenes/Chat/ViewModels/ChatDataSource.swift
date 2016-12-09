//
//  ChatDataSource.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

/**
 The source of chat data
 */
class ChatDataSource: NSObject {
    
    //MARK: Properties
    fileprivate var items: [ChatModel] = []
    
    ///The resusable identifier of my message box cell on collection view
    static let leftTextMessageIdentifier = "LeftTextMessageCell"
    ///The resusable identifier of partner message box cell on collection view
    static let rightTextMessageIdentifier = "RightTextMessageCell"
    
    //MARK: Init
    /**
     Init `ChatDataSource` object
     */
    override init() {
        super.init()
    }
    
    //MARK: Data item
    
    /**
     Get chat model item at given index path
     
     - Parameter:
        indexPath: given indexpath
     
     - Returns: 
        `ChatModel`: chat model object
     */
    func itemAt(indexPath: IndexPath) -> ChatModel {
        return items[indexPath.row]
    }
    
    /**
     Update list of `ChatModel` items
     
     - Parameter:
       items: new list of items
     */
    func update(items: [ChatModel]) {
        self.items = items
    }
    
    /**
     Append chat item to list
     
     - Parameter:
     item: given item
     */
    func append(item: ChatModel) {
        items.append(item)
    }
}

//MARK: Datasource
extension ChatDataSource: UICollectionViewDataSource {
    
    /**
     Read more at `UICollectionViewDataSource` `numberOfItemsInSection`
     */
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    /**
     Read more at `UICollectionViewDataSource` `cellForItemAt`
     */
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let message = itemAt(indexPath: indexPath)
        if message.isMine {
            if let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: ChatDataSource.rightTextMessageIdentifier,
                                     for: indexPath)
                as? RightTextMessageCell {
                cell.bind(chatModel: message)
                return cell
            }
        } else {
            if let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: ChatDataSource.leftTextMessageIdentifier,
                                     for: indexPath)
                as? LeftTextMessageCell {
                cell.bind(chatModel: message)
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension ChatDataSource: UICollectionViewDelegateFlowLayout {
    /**
     Read `UICollectionViewDelegateFlowLayout`
     */
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fixedWidth = collectionView.bounds.width > UIScreen.main.bounds.width
            ? UIScreen.main.bounds.width : collectionView.bounds.width
        let item = itemAt(indexPath: indexPath)
        
        if item.isMine {
            return collectionView
                .ar_sizeForCell(withIdentifier: ChatDataSource.rightTextMessageIdentifier,
                                indexPath: indexPath,
                                fixedWidth: fixedWidth,
                                configuration: { cell in
                                    if let cell = cell as? RightTextMessageCell {
                                        cell.bind(chatModel: item)
                                    }
                })
        }
        return collectionView
            .ar_sizeForCell(withIdentifier: ChatDataSource.leftTextMessageIdentifier,
                            indexPath: indexPath,
                            fixedWidth: fixedWidth,
                            configuration: { cell in
                                if let cell = cell as? LeftTextMessageCell {
                                    cell.bind(chatModel: item)
                                }
            })
    }
}
