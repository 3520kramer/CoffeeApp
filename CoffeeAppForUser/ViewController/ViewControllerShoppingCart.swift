//
//  ViewControllerShoppingCart.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 25/05/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import UIKit

class ViewControllerShoppingCart: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var orderTotalLabel: UILabel!
    @IBOutlet weak var orderCommentTextView: UITextView!
    
    var authManager: AuthorizationManager!
    
    var parentMenuVC: ViewControllerMenuForShop?
    var parentProductVC: ViewControllerProductInfo?
    
    var order: Order!
    
    var placeHolderText = "Add a comment to your order..."
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configures tableviews delegate and datasource
        tableView.dataSource = self
        tableView.delegate = self
        
        // initiates the Authorizationmanager to check if the user has a name
        authManager = AuthorizationManager(parentVC: self)
        
        // sets the order object
        // the parentMenuVC contains the order object
        if let parentMenuVC = parentMenuVC{
            order = parentMenuVC.order
        // to get to the order object from the productVC we need to access the parentVC from there
        }else if let parentProductVC = parentProductVC{
            order = parentProductVC.parentVC.order
        }
        
        // sets the order total label to the total of the order
        orderTotalLabel.text = "\(formatPrice(price: order.total)) dkk"
        
        // creates a placholder text in the textView
        orderCommentTextView.delegate = self
        orderCommentTextView.text = placeHolderText
        orderCommentTextView.textColor = UIColor.lightGray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    func formatPrice(price: Double) -> String{
        let formatter: String
               
       // if-statement to check if the number contains relevant digits or not
       if (price - floor(price) > 0.01) {
           formatter = "%.1f" // allow one digit
       }else{
           formatter = "%.0f" // will not allow any digits
       }
       
       // sets the pricelabel in the correct format
       return String(format: formatter, price)
    }
    
    @IBAction func placeOrderPressed(_ sender: Any) {
        if authManager.auth.currentUser?.displayName == nil{
            showMissingNameAlert()
        }else{
            order.comments = orderCommentTextView.text
            OrderRepo.addOrder(order: order)
            
            
            // the parentMenuVC contains the order object
            if let parentMenuVC = parentMenuVC{
                parentMenuVC.order = Order(userID: order.userID, customerName: order.customerName, coffeeShopID: order.coffeeShopID)
                order = parentMenuVC.order
            // to get to the order object from the productVC we need to access the parentVC from there
            }else if let parentProductVC = parentProductVC{
                parentProductVC.parentVC.order = Order(userID: order.userID, customerName: order.customerName, coffeeShopID: order.coffeeShopID)
                order = parentProductVC.parentVC.order
            }
            
            tableView.reloadData()
            
            showOrderConfirmation()
            
            
        }
    }
    
    func showOrderConfirmation(){
        let alertController = UIAlertController(title: "Succes", message: "Your purchase has been confirmed", preferredStyle: .alert)

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
    
    func showMissingNameAlert(){
        let alertController = UIAlertController(title: "Name missing", message: "You need to update your profile with a name to be able to make an order", preferredStyle: .alert)

        self.present(alertController, animated: true, completion:{
            alertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: nil))
        })
    }
}

extension ViewControllerShoppingCart: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        order.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = order.products[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableCell
        
        cell.setCell(product: product)
        return cell
    }
}

extension ViewControllerShoppingCart: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeHolderText
            textView.textColor = UIColor.lightGray
        }
    }
}
