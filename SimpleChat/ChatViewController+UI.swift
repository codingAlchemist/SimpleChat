//
//  ChatViewController+UI.swift
//  SimpleChat
//
//  Created by jason debottis on 11/10/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//
import UIKit
import SendBirdSDK
extension ChatViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:MessageCell?
        
        if self.messages[indexPath.row].sender?.nickname == SBDMain.getCurrentUser()?.nickname{
        
            cell = self.ChatTable.dequeueReusableCell(withIdentifier: "OutgoingCell", for: indexPath) as? MessageCell
        }else{
            cell = self.ChatTable.dequeueReusableCell(withIdentifier: "IncomingCell", for: indexPath) as? MessageCell
        }
        cell?.SetMessage(messageIn: self.messages[indexPath.row])
        return cell!
    }
}
