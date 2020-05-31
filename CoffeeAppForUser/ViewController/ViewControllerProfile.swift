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
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
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
            
            signInView.showLogInOption(parentVC: self, signInView: signInView, hideCancelButton: true)
        
            checkName()
        }else{
            checkName()
        }
    
        
        print("current user: \(authManager.auth.currentUser?.displayName)")
    }
    
    func checkName(){
        if let name = authManager.auth.currentUser?.displayName{
            infoLabel.text = "Name"
            nameTextField.text = name
        }else{
            infoLabel.text = "You need to enter your name to be able to place an order"
        }
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
    @IBAction func updateProfilePressed(_ sender: Any) {
        let changeRequest = authManager.auth.currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = nameTextField.text
        changeRequest?.commitChanges(completion: { (error) in
            if let error = error{
                print("Error updating profile")
            }else{
                guard let user = self.authManager.auth.currentUser else { return }
                
                if let user = user.displayName{
                    self.showUpdateProfileConfirmation(user: user)
                }
                
            }
        })
        
    }
    
    func showUpdateProfileConfirmation(user: String){
        let alertController = UIAlertController(title: "Succes", message: "Your profile has been updated, \(user)", preferredStyle: .alert)

        self.present(alertController, animated: true, completion:{
            alertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        })
    }
    
    // function that dismisses the view
     @objc func dismissOnTapOutside(){
         // dismisses the shopping cart
         dismiss(animated: false, completion: nil)
         
         // dimisses the alert controller
         self.dismiss(animated: true, completion: nil)
         
    }
    
}
