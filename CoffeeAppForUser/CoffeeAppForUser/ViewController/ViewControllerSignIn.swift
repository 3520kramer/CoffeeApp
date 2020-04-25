//
//  ViewControllerProfile.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 23/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import UIKit

class ViewControllerSignIn: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var authManager: AuthorizationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        authManager = AuthorizationManager.init(parentVC: self)
        
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        if let email = emailField.text, let password = passwordField.text{
            authManager.signIn(email: email, password: password)
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
