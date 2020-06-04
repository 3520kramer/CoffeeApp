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
    @IBOutlet weak var cancelButton: UIButton!
    
    // declares two buttonhandlers which gets initiated in the showLogInOption
    var signInButtonHandler: ((String, String) -> Void)?
    var cancelButtonHandler: (() -> Void)?
    
    // declares the authmanager
    var authManager: AuthorizationManager?
    
    // Handles when the user presses the sign in button
    @IBAction func signInPressed(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            signInButtonHandler?(email, password)
        }
    }
    
    // Handles if the user presses the cancel button
    @IBAction func cancelPressed(_ sender: Any) {
        cancelButtonHandler?()
    }
    
    // shows the log in option
    func showLogInOption(parentVC: UIViewController, signInView: SignInView, hideCancelButton: Bool){
        // creates a new view with a blurry effect
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        // Assigns it a tag as identifier
        blurEffectView.tag = 1
        
        // sets the frame of the view to be the bounds of the viewcontroller (everything except tab bar controller)
        blurEffectView.frame = parentVC.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // the view is added as a subview
        parentVC.view.addSubview(blurEffectView)
        
        // Assigns it a tag as identifier
        signInView.tag = 2
        
        // show the cancel button depending on the argument
        signInView.cancelButton.isHidden = hideCancelButton ? true : false
        
        // set it to center and adds it to the view
        signInView.center = parentVC.view.center
        parentVC.view.addSubview(signInView)
        
        // sets the authmanager to the parentVC
        authManager = AuthorizationManager(parentVC: parentVC)
        
        // if the sign in button is pressed, we need to perform the signing in at firebase
        signInView.signInButtonHandler = { email, password in
            self.authManager?.signIn(email: email, password: password)
        }
        
        // if the cancel button is pressed, we need to dismiss the view
        signInView.cancelButtonHandler = {
            
            // remvoes the signin view from the viewcontroller with animation
            UIView.transition(with: parentVC.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            }, completion: nil)
            
            // remvoes the blurry view and the signin view from the viewcontroller
            parentVC.view.viewWithTag(1)?.removeFromSuperview()
            parentVC.view.viewWithTag(2)?.removeFromSuperview()
        }
    }
    
    // function that hides the view
    func hideLogInOption(parentVC: UIViewController){
        parentVC.view.viewWithTag(1)?.removeFromSuperview() // removes sign in box
        parentVC.view.viewWithTag(2)?.removeFromSuperview() // removes blur effect
    }
}
