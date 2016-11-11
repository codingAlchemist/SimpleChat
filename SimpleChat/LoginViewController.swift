
import UIKit
import SendBirdSDK

class LoginViewController: UIViewController, AlertHelperDelegate{

    @IBOutlet weak var EnterUserIDTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SBDMain.initWithApplicationId(Constants.APP_ID)
        self.initNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func Login(_ sender: Any) {
        let alert = AlertHelper(parentIn: self, delegateIn: self)
        
        SBDMain.connect(withUserId: self.EnterUserIDTextField.text!) { (user, error) in
            if(error == nil){
                let chatViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChatTable") as! ChatViewController
                self.show(chatViewController, sender: self)
            }else{
                alert.BuildAlert(messageIn: "Error connecting:\(error)", title: "Error")
                    .ShowAlert()
            }
        }
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
        
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y = -140
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y = 0
            self.view.layoutIfNeeded()
        }
        
    }
    

    func OkPressed() {
        
    }
}

