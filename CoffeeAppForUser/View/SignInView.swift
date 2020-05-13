//
//  SignInView.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 12/05/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInView: UIView {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var buttonHandler: ((String, String) -> Void)?
    
    
    @IBAction func signInPressed(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            buttonHandler?(email, password)
        }
    }
    

}
