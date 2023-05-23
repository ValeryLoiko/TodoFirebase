//
//  ViewController.swift
//  ToDoFirebase
//
//  Created by Diana on 21/05/2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var validLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + keyboardSize.height)
        
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
    }
    
    @objc private func keyboardDidHide(notification: Notification) {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }

    @IBAction func loginAction(_ sender: UIButton) {
    }
    
    @IBAction func registerAction(_ sender: Any) {
    }
}

