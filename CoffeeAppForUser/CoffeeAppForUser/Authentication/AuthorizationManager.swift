//
//  AuthorizationManager.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 23/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthorizationManager{
    
    var handle: AuthStateDidChangeListenerHandle
    var auth = Auth.auth()
    
    let parentVC: UIViewController
    
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
    
    func closeListener(){
        self.auth.removeIDTokenDidChangeListener(handle)
    }
    
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password)  { (authResult, error) in
            // perform segue
            if error == nil {
                print("signed up succesfully")
                print(authResult?.user.email)
                
                //self.parentVC.performSegue(withIdentifier: "personalSegue", sender: nil)
            }else{
                print("Error: \(error.debugDescription)")
            }
        }
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let self = self else { return }
                          
            
            if error == nil{
                print("SUCCES")
                
                self.parentVC.dismiss(animated: true, completion: nil)
            }else{
                print("Failed")
            }
        }
    }
    
    func signOut(){
        do {
            try auth.signOut()
        } catch let error {
            print("Failed: \(error.localizedDescription)")
        }
    }
}
