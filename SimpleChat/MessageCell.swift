//
//  MessageCell.swift
//  SimpleChat
//
//  Created by jason debottis on 11/10/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit
import SendBirdSDK
class MessageCell: UITableViewCell {

    @IBOutlet weak var TimeStamp: UILabel!
    @IBOutlet weak var MessageText: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var ProfileImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func SetMessage(messageIn: SBDUserMessage) -> Void {
        if messageIn.message != nil {
            let date = Date()
            self.MessageText.text = messageIn.message
            self.Name.text = messageIn.sender?.nickname
            self.TimeStamp.text = DateHelper.getStringFromDate(dateIn: date)
            if (messageIn.sender?.profileUrl?.isEmpty == true) {
                self.ProfileImage.backgroundColor = UIColor.darkGray
            }
            do{
                try self.ProfileImage.image = UIImage(data: Data(contentsOf: URL(string: (messageIn.sender?.profileUrl)!)!))
            }catch{
                print("Error: \(error)")
            }
            
        }
        
    }


}
