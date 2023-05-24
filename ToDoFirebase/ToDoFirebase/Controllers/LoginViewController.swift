//
//  ViewController.swift
//  ToDoFirebase
//
//  Created by Diana on 21/05/2023.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    var ref: DatabaseReference!
    let segueIdentify = "loginSegue"
    
    @IBOutlet weak var validLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(withPath: "users")
        
        validLabel.alpha = 0
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if user != nil {
                self?.performSegue(withIdentifier: self!.segueIdentify, sender: nil)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text = ""
        passwordTextField.text = ""
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
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            displayWarningLabel(withText: "Info is incorrect")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            if error != nil {
                self?.displayWarningLabel(withText: "Error occured")
                return
            }
            
            if user != nil {
                self?.performSegue(withIdentifier: "loginSegue", sender: nil)
                return
            }
            self?.displayWarningLabel(withText: "No such user")
        }
    }
    
    @IBAction func registerAction(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            displayWarningLabel(withText: "Info is incorrect")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self]    (userFIR, error) in
            guard error == nil, let user = userFIR?.user else {
                print(error!.localizedDescription)
                return
            }
            let userRef = self?.ref.child(user.uid)
            userRef?.setValue(["email": user.email])
        }
    }
    
    func displayWarningLabel(withText text: String) {
        validLabel.text = text
        
        UIView.animate(withDuration: 3, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, animations: { [weak self] in
            self?.validLabel.alpha = 1
        }) { [weak self] complete in
            self?.validLabel.alpha = 0
        }
    }
}

