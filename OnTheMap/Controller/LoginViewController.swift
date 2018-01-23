//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Farzad on 12/29/17.
//  Copyright © 2017 Farzad Zamani. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var sighUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
   
    }
    @IBAction func sighUP(_ sender: Any) {
        goTo(url: "https://www.udacity.com/account/auth#!/signup")
    }
    
    @IBAction func login(_ sender: Any) {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
            
        if username == "" || password == "" {
           alert(view: self, title: "ALERT", message: "Please Input Username And Password")
            return
        }
        
        UdacityApi.shared.getSessionIdWith(username: username, password: password) { (error) in
            if let error = error {
                 alert(view: self, title: "Error", message: error.description)
            } else {
                    performUIUpdatesOnMain {
                   self.performSegue(withIdentifier: "LoginSeque", sender: nil)
                        
                }
            }
            
        }
        
    }
    
}
