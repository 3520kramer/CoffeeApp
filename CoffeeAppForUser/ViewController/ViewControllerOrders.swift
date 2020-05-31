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
    
    var authManager: AuthorizationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        authManager = AuthorizationManager(parentVC: self)
        
        print(authManager.auth.currentUser?.uid)
        if let user_id = authManager.auth.currentUser?.uid{
            OrderRepo.startListener(vc: self, user_id: user_id)
        }else{
            presentMissingSigningInAlert()
        }
    }
    
    // creates an alert controller and adds two actions; sign in or continue browsing
    func presentMissingSigningInAlert(){
        let alertController = UIAlertController(title: "To be able to see your orders you need to be signed in", message: "", preferredStyle: .alert)
            
        alertController.addAction(UIAlertAction(title: "Sign In", style: .default, handler: { (action) in
            // loads the view and assign it as a SignInView
            let views = Bundle.main.loadNibNamed("SignInView", owner: nil, options: nil)
            let signInView = views?[0] as! SignInView
            
            signInView.showLogInOption(parentVC: self, signInView: signInView, hideCancelButton: false)
            
        }))
    
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ViewControllerOrders: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrderRepo.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = OrderRepo.orders[indexPath.row]

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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
