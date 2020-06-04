//
//  AuthorizationManager.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 23/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import Foundation
import FirebaseAuth // imports firebase authentication module

class AuthorizationManager{
    
    // declares a handle so we are able to close the auth listener later
    var handle: AuthStateDidChangeListenerHandle
    
    // the auth object which holds the data
    var auth = Auth.auth()
    
    // the view controller to which we need to update
    let parentVC: UIViewController
    
    // when initializing the authrizationManager object, we add a listener which listens for updates to the auth object
    init(parentVC: UIViewController){
        self.parentVC = parentVC
        
        handle = auth.addStateDidChangeListener(){ (auth, user) in
            
            if let user = user {
                print("ID: \(user.uid)")
                print("Name: \(user.displayName)")
                print("Email: \(user.email)")
            }
        }
    }
    
    // responsible for closing the listener
    func closeListener(){
        self.auth.removeIDTokenDidChangeListener(handle)
    }

    // handles the signing in of a user
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let self = self else { return }
        
            if error == nil{
                print("SUCCES")
                // remvoes the signin view from the viewcontroller with animation
                UIView.transition(with: self.parentVC.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {

                }, completion: nil)
                
                // remvoes the blurry view and the signin view from the viewcontroller
                self.parentVC.view.viewWithTag(1)?.removeFromSuperview()
                self.parentVC.view.viewWithTag(2)?.removeFromSuperview()
            }else{
                print("Failed")
            }
        }
    }
    
    // FOR DEMO PURPOSES - a sign out function
    func signOut(){
        do {
            try auth.signOut()
        } catch let error {
            print("Failed: \(error.localizedDescription)")
        }
    }
}
