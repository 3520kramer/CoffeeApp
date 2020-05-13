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

        authManager = AuthorizationManager.init(parentVC: self)
            
    }
    
    // Everything in this function will get called every time the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if authManager.auth.currentUser == nil{
            print("showing login")
            showLogInOption()
        }
        
        print("current user: \(authManager.auth.currentUser)")
    }
    
    // Everything in this function will get called when the view disappears
    override func viewDidDisappear(_ animated: Bool) {
        hideLogInOption()
    }
    
    func showLogInOption(){
        // creates a new view with a blurry effect
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        // Assigns it a tag as identifier
        blurEffectView.tag = 1
        
        // sets the frame of the view to be the bounds of the viewcontroller (everything except tab bar controller)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // the view is added as a subview
        view.addSubview(blurEffectView)
        
        // loads the view and assign it as a SignInView
        let views = Bundle.main.loadNibNamed("SignInView", owner: nil, options: nil)
        let signInView = views?[0] as! SignInView
        
        // Assigns it a tag as identifier
        signInView.tag = 2
        
        // set it to center and adds it to the view
        signInView.center = view.center
        view.addSubview(signInView)
        
        // when the button is pressed, we need to perform the signing in at firebase
        signInView.buttonHandler = { email, password in
            self.authManager.signIn(email: email, password: password)
        }
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
