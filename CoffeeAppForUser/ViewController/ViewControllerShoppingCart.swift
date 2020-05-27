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
    
    var order: Order!
    
    var placeHolderText = "Add a comment to your order..."
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configures tableviews delegate and datasource
        tableView.dataSource = self
        tableView.delegate = self
        
        orderTotalLabel.text = String(order.total)
        
        // creates a placholder text in the textView
        orderCommentTextView.delegate = self
        orderCommentTextView.text = placeHolderText
        orderCommentTextView.textColor = UIColor.lightGray
    }
    
    @IBAction func placeOrderPressed(_ sender: Any) {
        OrderRepo.addOrder(order: order)
        showOrderConfirmation()
    }
    
    func showOrderConfirmation(){
        let alertController = UIAlertController(title: "Succes", message: "Your purchase is confirmed", preferredStyle: .alert)

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

extension ViewControllerShoppingCart: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        order.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = order.products[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableCell
        //cell.textLabel?.text = product.name
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
