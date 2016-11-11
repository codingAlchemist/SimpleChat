//
//  ChatTableTableViewController.swift
//  SimpleChat
//
//  Created by jason debottis on 11/10/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit
import SendBirdSDK

class ChatViewController: UIViewController,
                            SBDChannelDelegate,
                            UITableViewDataSource,
                            UITableViewDelegate{

    @IBOutlet weak var ChatTable: UITableView!
    @IBOutlet weak var EnterMessageTextField: UITextField!
    
    var currentChannel:SBDBaseChannel?
    
    var messages = [SBDUserMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ChatTable.dataSource = self
        self.ChatTable.delegate = self
        
        self.initNotifications()
        
        SBDOpenChannel.getWithUrl("TestChannel") { (channel, error) in
            if(error != nil){
                print("Error \(error)")
                return
            }else{
                channel?.enter(completionHandler: { (error) in
                    if error != nil{
                        print("Error \(error)")
                        return
                    }else{
                        self.currentChannel = channel
                    }
                })
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SBDMain.add(self, identifier: "channelDelegate")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func SendMessage(_ sender: Any) {
        self.currentChannel?.sendUserMessage(self.EnterMessageTextField.text, completionHandler: { (message, error) in
            if(error != nil){
                return
            }else{
                self.messages.append(message!)
                self.ChatTable.reloadData()
                self.scrollToBottom()
            }
            
            
        })
    }
    
    func initSBDMain() {
        
    
    }
    //MARK: SBDChannelDelegate
    func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage) {
        
        let messageRecieved:SBDUserMessage = message as! SBDUserMessage
        
        self.messages.append(messageRecieved)
        self.ChatTable.reloadData()
        self.scrollToBottom()
    }
    
    
    //MARK: Keyboard methods
    func initNotifications() -> Void {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardDidHide,
                                               object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y = -keyboardSize.height
                self.view.layoutIfNeeded()
            }
        }
        
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
            self.view.layoutIfNeeded()
        }
        
    }
    
    @IBAction func hideKeyboard(){
        if self.EnterMessageTextField.isFirstResponder {
            self.EnterMessageTextField.resignFirstResponder()
        }
    }
}
