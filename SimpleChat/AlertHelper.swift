//
//  AlertHelper.swift
//  SimpleChat
//
//  Created by jason debottis on 11/10/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit
protocol AlertHelperDelegate {
    func OkPressed()
}
class AlertHelper<controller: UIViewController>: NSObject{
    var alertController: UIAlertController?
    let parent: controller
    let delegte:AlertHelperDelegate?

    init(parentIn: controller, delegateIn: AlertHelperDelegate) {
        self.parent = parentIn
        self.delegte = delegateIn
    }
    
    public func BuildAlert(messageIn: String, title: String) -> Self{
        self.alertController = UIAlertController(title: title,
                                                message: messageIn,
                                                preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.delegte?.OkPressed()
            self.alertController!.dismiss(animated: true, completion: nil)
        }
        
        alertController!.addAction(dismissAction)
        return self
    }
    
    public func ShowAlert(){
        self.parent.show(self.alertController!, sender: self)
    }
}
