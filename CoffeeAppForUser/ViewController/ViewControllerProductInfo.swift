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
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    var product: Product!
    var parentVC: ViewControllerMenuForShop!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets the labels to the product info
        productName.text = product.name
        productPrice.text = String(product.price)
        
    }
    
    @IBAction func checkOutPressed(_ sender: Any) {
        performSegue(withIdentifier: "showShoppingCart", sender: nil)
    }
    
    @IBAction func addToCartPressed(_ sender: Any) {
        parentVC.order?.addProductToOrder(product: product)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ViewControllerShoppingCart{
            
            destination.preferredContentSize = CGSize(width:250, height:400)
            
            let presentationController = destination.popoverPresentationController
            presentationController?.delegate = self
            
            guard let order = parentVC.order else { return }
            destination.order = order
        }
    }
    
    
    
}

extension ViewControllerProductInfo: UIPopoverPresentationControllerDelegate{
        
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
}
