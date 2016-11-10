//
//  ViewController.swift
//  SimpleChat
//
//  Created by jason debottis on 11/10/16.
//  Copyright © 2016 jason debottis. All rights reserved.
//

import UIKit
import SendBirdSDK

class LoginViewController: UIViewController, AlertHelperDelegate{

    @IBOutlet weak var EnterUserIDTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SBDMain.initWithApplicationId(Constants.APP_ID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Login(_ sender: Any) {
        let alert = AlertHelper(parentIn: self, delegateIn: self)

        SBDMain.connect(withUserId: self.EnterUserIDTextField.text!) { (user, error) in
            if(error == nil){
               alert.BuildAlert(messageIn: "Success", title: "Success")
                    .ShowAlert()
            }else{
                alert.BuildAlert(messageIn: "Error connecting:\(error)", title: "Error")
                    .ShowAlert()
            }
        }
    }
    
    func OkPressed() {
        
    }
}

