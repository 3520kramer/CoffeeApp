//
//  ViewControllerInfo.swift
//  CoffeeAppForUser
//
//  Created by Nadia Oubelaid on 28/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewControllerProductInfo: UIViewController{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // declares a product which get initiated from the segue
    var product: Product!
    var parentVC: ViewControllerMenuForShop!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets the labels to the product info
        nameLabel.text = product.name
        sizeLabel.text = product.size
        quantityLabel.text = product.quantity
        priceLabel.text = "\(formatPrice(price: product.price)) dkk" 
        
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
    
    
    @IBAction func checkOutPressed(_ sender: Any) {
        if parentVC.order != nil{
            performSegue(withIdentifier: "showShoppingCart", sender: nil)
        }
    }
    
    @IBAction func addToCartPressed(_ sender: Any) {
        if parentVC.order != nil{
            parentVC.order?.addProductToOrder(product: product)
        }
    }
    // prepare for the pop up segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ViewControllerShoppingCart{
            
            destination.preferredContentSize = CGSize(width:250, height:400)
            
            let presentationController = destination.popoverPresentationController
            presentationController?.delegate = self
            
            destination.parentProductVC = self
        }
    }
    
    
    
}

// pop over presentation controller setup
extension ViewControllerProductInfo: UIPopoverPresentationControllerDelegate{
        
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
}
