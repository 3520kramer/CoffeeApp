//
//  ViewControllerInfo.swift
//  CoffeeAppForUser
//
//  Created by Nadia Oubelaid on 28/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewControllerInfo: UIViewController{
    
    @IBOutlet weak var productDetail: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    var authManager: AuthorizationManager!
    var product: Product!
    var newOrder: Order?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        authManager = AuthorizationManager(parentVC: self)
        
        // sets the labels to the product info
        productDetail.text = product.name
        productPrice.text = String(product.price)
        
        // if the user is logged in we create a new order
        if let email = authManager.auth.currentUser?.email{
            newOrder = Order(customerEmail: email)
        }
    
        
    }
    
    // adds the order to firebase and show a confirmation alert
    @IBAction func buyButton(_ sender: Any) {

        newOrder?.addProductToOrder(product: product)
        
        if let newOrder = newOrder {
            
            OrderRepo.addOrder(order: newOrder)
            
            showOrderConfirmation()
        }
    }
    
    // alert controller property
    func showOrderConfirmation(){
        let alertController = UIAlertController(title: "Succes", message: "Your purchase is confirmed", preferredStyle: .alert)
        
        self.present(alertController, animated: true, completion:{
           alertController.view.superview?.isUserInteractionEnabled = true
           alertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        })
    }
    
    // function that dismisses the view
    @objc func dismissOnTapOutside(){
        self.dismiss(animated: true, completion: nil)
    }
    
}
