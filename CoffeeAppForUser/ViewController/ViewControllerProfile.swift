//
//  ViewControllerLogIn.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 23/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import UIKit

class ViewControllerProfile: UIViewController {

    var authManager: AuthorizationManager!
    
    // Everything in this function will get called the first time the view appears
    override func viewDidLoad() {
        super.viewDidLoad()

        authManager = AuthorizationManager(parentVC: self)

    }
    
    // Everything in this function will get called every time the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if authManager.auth.currentUser == nil{
            print("showing login")
            // loads the view and assign it as a SignInView
            let views = Bundle.main.loadNibNamed("SignInView", owner: nil, options: nil)
            let signInView = views?[0] as! SignInView
            
            signInView.showLogInOption(parentVC: self, signInView: signInView, hideCancelButton: false)
        }
        
        print("current user: \(authManager.auth.currentUser)")
    }
    
    // Everything in this function will get called when the view disappears
    override func viewDidDisappear(_ animated: Bool) {
        hideLogInOption()
    }
    
    // function that hides the view
    func hideLogInOption(){
        view.viewWithTag(1)?.removeFromSuperview() // removes sign in box
        view.viewWithTag(2)?.removeFromSuperview() // removes blur effect
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        authManager.signOut()
    }
    
}
