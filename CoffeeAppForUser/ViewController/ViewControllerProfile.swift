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
        
        // Do any additional setup after loading the view.
        
    }
    
    // Everything in this function will get called every time the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if authManager.auth.currentUser == nil{
            showLogInOption()
        }
        
        print("current user: \(authManager.auth.currentUser)")
    }
    
    // Everything in this function will get called when the view disappears
    override func viewDidDisappear(_ animated: Bool) {
        // what
    }
    

    func showLogInOption(){
        // Creates a new viewcontroller which slides up from the bottom
        let ViewControllerSignIn = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "signIn") as ViewControllerSignIn
        
        // A 'UIView' was created on the new view controller in the storyboard, and moved to the bottom of the view controller
        // The background of the pop up view controllers opacity is set to 0 and the presentation style is set to 'over current context' to make sure it's on top of the old view
        // This makes the rest of the view controller 'invisible', so when the 'UIView' pops up, the rest of the view controller isn't visible
        ViewControllerSignIn.modalPresentationStyle = .overCurrentContext
        
        // The crossdisolve creates the effect we want, instead of the view's sliding up from the bottom
        ViewControllerSignIn.modalTransitionStyle = .crossDissolve
        
        // creates a new view with a blurry effect
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds // TODO: could be changed so it doesn't include the tap bar
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // the view is added as a subview and then placed behind the login form pop up
        ViewControllerSignIn.view.addSubview(blurEffectView)
        ViewControllerSignIn.view.sendSubviewToBack(blurEffectView)
        
        // The new view is presented on top of the old view controller
        present(ViewControllerSignIn, animated: true, completion: {
            // When tapping outside of the view, the pop up will be dismissed
            // TODO: CHANGE THIS TO NOT DISMISSING THE VIEW UNLESS YOU TAP THE TAP BAR
            ViewControllerSignIn.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        })
    }
    
    @objc func dismissOnTapOutside(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        authManager.signOut()
    }
    
}
