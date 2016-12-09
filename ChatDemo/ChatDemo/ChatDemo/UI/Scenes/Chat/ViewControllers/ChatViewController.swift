//
//  ChatViewController.swift
//  ChatDemo
//
//  Created by Duong Tran Tu on 12/8/16.
//  Copyright © 2016 Duong Tran. All rights reserved.
//

import UIKit

class ChatViewController: BaseViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet fileprivate weak var constraintToolbarBottom: NSLayoutConstraint!
    @IBOutlet fileprivate weak var constraintTextViewMessageHeight: NSLayoutConstraint!
    @IBOutlet fileprivate weak var chatCollectionView: UICollectionView! {
        didSet {
            chatCollectionView.delegate = chatDataSource
            chatCollectionView.dataSource = chatDataSource
        }
    }
    
    @IBOutlet private weak var buttonSend: UIButton! {
        didSet {
            buttonSend.isEnabled = false
        }
    }
    @IBOutlet private weak var textViewMessage: PlaceholderTextView! {
        didSet {
            textViewMessage.layer.cornerRadius = 5
            textViewMessage.layer.masksToBounds = true
            textViewMessage.applyPlaceholderStyle(placeholderText: "Nhập tin nhắn")
        }
    }
    
    //MARK: Properties
    fileprivate let chatDataSource = ChatDataSource()
    fileprivate var viewModel: ChatViewModel! {
        didSet {
            
        }
    }
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ChatViewModel(chatService: Components.chatService)
        configCollectionView()
        bindData()
        bindEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotification()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let item1 = ChatModel(id: "1", message: "I agree but in some cases UITableView also is better than collection view like tableViewFooter ", time: 1000000077, isMine: false)
        let item2 = ChatModel(id: "2", message: "abc 2", time: 1000000079, isMine: true)
        chatDataSource.update(items: [item1, item2, item1, item2, item1, item2, item1, item2])
        chatCollectionView.reloadData()
        scrollToBottom()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeKeyboardNotification()
    }
    
    //MARK: Keyboard
    ////////////////////////////////////////////////////////////////////////////
    
    private func registerKeyboardNotification() {
        NotificationCenter.default
            .addObserver(self, selector: #selector(ChatViewController.keyboardWillShow),
                         name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default
            .addObserver(self, selector: #selector(ChatViewController.keyboardWillHide),
                         name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let info = notification.userInfo,
            let keyboard = info[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame: CGRect = keyboard.cgRectValue
            constraintToolbarBottom.constant = keyboardFrame.height
            UIView.animate(withDuration: 0.10) {[unowned self] _ in
                self.view.layoutIfNeeded()
            }
            scrollToBottom()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        constraintToolbarBottom.constant = 0
        UIView.animate(withDuration: 0.15) {[unowned self] _ in
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: Actions
    @IBAction func clickOnSendButton(_ sender: AnyObject) {
        viewModel.sendMessage(message: textViewMessage.text)
    }
    
    @IBAction func clickOnReceiveButton(_ sender: AnyObject) {
        viewModel.receiveMessage()
    }
    
    @IBAction func tapOnCollectionView(_ sender: AnyObject) {
        hideKeyboard()
    }
 
    //MARK: Bind data
    private func bindData() {
        disposeBag.addDisposables(array: [
            viewModel.onReceivedMessage.subscribe(onNext: {[unowned self] (chatModel) in
                if let indexPath = self.getLastIndexPath() {
                    self.insertMessage(indexPath: IndexPath(row: indexPath.row + 1, section: 0), newItem: chatModel)
                    self.scrollToBottom()
                } else {
                    self.chatDataSource.append(item: chatModel)
                    self.chatCollectionView.reloadData()
                }
                
                
                }, onError: { (error) in
                    
                }, onCompleted: { 
                    
                }, onDisposed: { 
                    
            })
        ])
    }
    
    //MARK: Bind event
    private func bindEvent() {
        disposeBag.addDisposables(array: [
            viewModel.onUpdateTextViewSize.subscribe(onNext: {[unowned self] height in
                    self.constraintTextViewMessageHeight.constant = height
                    UIView.animate(withDuration: 0.15) {
                        self.textViewMessage.layoutIfNeeded()
                    }
                    self.textViewMessage.isScrollEnabled = false
                    let selectedRange = self.textViewMessage.selectedRange
                    self.textViewMessage.scrollRangeToVisible(selectedRange)
                    self.textViewMessage.isScrollEnabled = true
                }, onError: { error in
                    
                }, onCompleted: {
                    
                }, onDisposed: {
                    
            }),
            viewModel.onClearTextViewMessage.subscribe(onNext: {[unowned self] _ in
                    self.textViewMessage.clear()
                    let height = self.viewModel.defaultTextviewHeight
                    self.constraintTextViewMessageHeight.constant = height
                }, onError: { error in
                    
                }, onCompleted: {
                    
                }, onDisposed: {
                    
            }),
            viewModel.onEnableSendButton.subscribe(onNext: {[unowned self] enable in
                    self.buttonSend.isEnabled = enable
                }, onError: { error in
                    
                }, onCompleted: {
                    
                }, onDisposed: {
                    
            })
        ])
    }
}

//MARK: Collection view
extension ChatViewController {
    
    fileprivate func getLastIndexPath() -> IndexPath? {
        let lastIndex = chatCollectionView.numberOfItems(inSection: 0) - 1
        return IndexPath(row: lastIndex >> 0, section: 0)
    }
    
    fileprivate func insertMessage(indexPath: IndexPath,
                                   newItem: ChatModel) {
        chatDataSource.append(item: newItem)
        chatCollectionView.insertItems(at: [indexPath])
    }
    
    fileprivate func configCollectionView() {
        chatCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0)
        
        let leftTextMessageIdentifier = ChatDataSource.leftTextMessageIdentifier
        chatCollectionView.register(UINib.init(nibName: leftTextMessageIdentifier,
                                              bundle: Bundle.main),
                                   forCellWithReuseIdentifier: ChatDataSource.leftTextMessageIdentifier)
        let rightTextMessageIdentifier = ChatDataSource.rightTextMessageIdentifier
        chatCollectionView.register(UINib.init(nibName: rightTextMessageIdentifier,
                                               bundle: Bundle.main),
                                    forCellWithReuseIdentifier: ChatDataSource.rightTextMessageIdentifier)
        chatCollectionView.alwaysBounceVertical = true
    }
    
    fileprivate func scrollToBottom() {
        if let lastIndexPath = getLastIndexPath() {
            chatCollectionView.scrollToItem(at: lastIndexPath, at: UICollectionViewScrollPosition.bottom, animated: true)
        }
    }
}

//MARK: UITextViewDelegate
extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.textViewMessageDidChange(textView: textView)
    }
}
