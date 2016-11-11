//
//  Message.swift
//  SimpleChat
//
//  Created by jason debottis on 11/10/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import Foundation
import SendBirdSDK

class Message{
    var user:SBDUser?
    var textMessage:String?
    
    init(userIn: SBDUser, textMessageIn: String, timeStamp: String) {
        self.textMessage = textMessageIn
        self.user = userIn
    }
}
