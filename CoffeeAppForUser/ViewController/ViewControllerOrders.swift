//
//  ViewControllerOrderPage.swift
//  CoffeeAppForUser
//
//  Created by Nadia Oubelaid on 07/05/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerOrders: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // declares the authorization manager
    var authManager: AuthorizationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableview setup
        tableView.delegate = self
        tableView.dataSource = self
        
        // authorization setup
        authManager = AuthorizationManager(parentVC: self)
        
        // checks if the user is logged in
        if let user_id = authManager.auth.currentUser?.uid{
            // starts listening for data from the user who is signed in
            OrderRepo.startListener(vc: self, user_id: user_id)
        }else{
            presentMissingSigningInAlert()
        }
    }
    
    // closes the listener when the view is removed
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        authManager.closeListener()
    }
    
    // creates an alert controller and adds two actions; sign in or continue browsing
    func presentMissingSigningInAlert(){
        let alertController = UIAlertController(title: "To be able to see your orders you need to be signed in", message: "", preferredStyle: .alert)
            
        alertController.addAction(UIAlertAction(title: "Sign In", style: .default, handler: { (action) in
            // loads the view and assign it as a SignInView
            let views = Bundle.main.loadNibNamed("SignInView", owner: nil, options: nil)
            let signInView = views?[0] as! SignInView
            
            signInView.showLogInOption(parentVC: self, signInView: signInView, hideCancelButton: true)
            
        }))
    
        self.present(alertController, animated: true, completion: nil)
    }
}

// table view setup
extension ViewControllerOrders: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // checks if the user has any orders
        // if not we return 1
        if OrderRepo.orders.count == 0{
            return 1
        // or else we return the count of the order list
        }else{
            return OrderRepo.orders.count
        }
        
    }
    
    // sets the cells at each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // if no orders we create a cell with the text "no orders yet"
        if OrderRepo.orders.count == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath)
            cell.textLabel!.text = "No orders yet"
            
            return cell
        }
        
        // if the user has orders then we set the order
        let order = OrderRepo.orders[indexPath.row]

        // The cell is dependant of if the order has a comment or not
        if order.hasComment(){
            let cell = tableView.dequeueReusableCell(withIdentifier: "withComment", for: indexPath) as! OrderCellWithComment
            
            cell.setCell(order: order)
            
            return cell
        
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "withoutComment", for: indexPath) as! OrderCellWithoutComment
            
            cell.setCell(order: order)
            
            return cell
        }
        
    }
    
    // sets the height of the cell depending on the users number of orders, and if the order has a comment or not
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if OrderRepo.orders.count == 0{
            return 30
        }
        
        let order = OrderRepo.orders[indexPath.row]
        
        if order.hasComment(){
            // the height of the cell varies depending on the number of products in the order
            let height = CGFloat(integerLiteral: 200 + (order.products.count * 20))
            return height
        }else{
            // the height of the cell varies depending on the number of products in the order
            let height = CGFloat(integerLiteral: 150 + (order.products.count * 20))
            return height
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // removes the gray color shown when selecting a row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
