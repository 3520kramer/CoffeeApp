//
//  ViewControllerInfo.swift
//  CoffeeAppForUser
//
//  Created by Nadia Oubelaid on 28/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import UIKit

class ViewControllerInfo: UIViewController{
    
    @IBOutlet weak var productDetail: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
  
    var product: Product?
    var newOrder: Order?

    override func viewDidLoad() {
        super.viewDidLoad()
        newOrder = Order()
        print(product?.name)
        if let product = product {
            productDetail.text = product.name
            productPrice.text = String(product.price)
        }
        
    }
    
    @IBAction func buyButton(_ sender: Any) {
        if let product = product{
          newOrder?.addProductToOrder(product: product)
        }
        if let newOrder = newOrder {
            OrderRepo.addOrder(order: newOrder)
            
            
        }
        
        
        
    
      }
     
    
}
