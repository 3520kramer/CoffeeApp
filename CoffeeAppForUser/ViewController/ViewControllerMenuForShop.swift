//
//  ViewControllerMenu.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 14/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import UIKit

class ViewControllerMenuForShop: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    // declares an object as optional, so we can check if it is initialized
    var order: Order?
    var coffeeShop: CoffeeShop?
    var selectedProduct: Product?
    
    // declares the authorization manager
    var authManager: AuthorizationManager!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // sets the delegate and datasource for the table
        tableView.delegate = self
        tableView.dataSource = self
        
        // uses the collectionID which we get from the list of coffeeshops to fetch the products of the coffeeshops and then reloads the tabledata when finished
        if let id = coffeeShop?.id{
            ProductRepo.startListener(id: id){
                self.tableView.reloadData()
                
            }
        }
    }
    
    // when the view did appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // sets the authorizationmanager
        authManager = AuthorizationManager(parentVC: self)
        
        // checks if the user is signed in or else it returns from the function
        guard let userID = authManager.auth.currentUser?.uid else {
            presentMissingSigningInAlert()
            return
        }
        
        // checks if the user has a name or else it returns from the function
        guard let name = authManager.auth.currentUser?.displayName else {
            presentMissingNameAlert()
            return
        }
        
        // if the name and id is present then we can create an order
        if let coffeeShop = coffeeShop{
            order = Order(userID: userID, customerName: name, coffeeShopID: coffeeShop.id)
        }
        
    }
    
    // when the view disappears we need to stop the listener
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        authManager.closeListener()
    }
    
    // when pressing checkout
    @IBAction func checkoutPressed(_ sender: Any) {
        guard let order = order else {
            presentMissingSigningInAlert()
            return
        }
        performSegue(withIdentifier: "showShoppingCart", sender: nil)
    }
    
    // creates an alert controller and adds two actions; sign in or continue browsing
    func presentMissingSigningInAlert(){
        let alertController = UIAlertController(title: "To be able to make an order you need to be signed in", message: "Please sign in", preferredStyle: .alert)
            
        // adds an action the the alert controller
        alertController.addAction(UIAlertAction(title: "Sign In", style: .default, handler: { (action) in
            // loads the view and assign it as a SignInView
            let views = Bundle.main.loadNibNamed("SignInView", owner: nil, options: nil)
            let signInView = views?[0] as! SignInView
            
            signInView.showLogInOption(parentVC: self, signInView: signInView, hideCancelButton: false)
            
        }))
        alertController.addAction(UIAlertAction(title: "Never mind", style: .cancel, handler: nil))
    
        self.present(alertController, animated: true, completion: nil)
    }
    
    // presents the missing name alert
    func presentMissingNameAlert(){
        let alertController = UIAlertController(title: "Name missing", message: "You need to update your profile with a name to be able to make an order", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Update profile", style: .default, handler: { (action) in
            // creates the profile view controller
            let viewControllerProfile = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewControllerProfile") as ViewControllerProfile
            
            // presents the view controller if the update profile button has been pressed
            self.present(viewControllerProfile, animated: true, completion: nil)
            
            
        }))
        
        // presents the alertcontroller
        self.present(alertController, animated: true, completion:{
            alertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        })
     }
        
    // function that dismisses the view if user taps outside of the alert box
    @objc func dismissOnTapOutside(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // pass object to next viewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProduct"{
            // if we are using the segue to the product info view controller
            if let destination = segue.destination as? ViewControllerProductInfo{
                if let selectedProduct = selectedProduct{
                    destination.parentVC = self
                    destination.product = selectedProduct
                }
            }
        }else if segue.identifier == "showShoppingCart"{
            if let destination = segue.destination as? ViewControllerShoppingCart{
                
                destination.preferredContentSize = CGSize(width:250, height:400)
                
                let presentationController = destination.popoverPresentationController
                presentationController?.delegate = self
                
                destination.parentMenuVC = self
            }
        }
    }
    
}

// table view setup
extension ViewControllerMenuForShop: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductRepo.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = ProductRepo.productList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableCell
        
        cell.setCell(product: product)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = ProductRepo.productList[indexPath.row]
        performSegue(withIdentifier: "showProduct", sender: nil)
    }
    

}

// pop over presentation controller setup
extension ViewControllerMenuForShop: UIPopoverPresentationControllerDelegate{
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}

       

