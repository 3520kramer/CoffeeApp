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
    
    @IBAction func buyButton(_ sender: Any) {
    }
   
    
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(product?.name)
        if let product = product {
            productDetail.text = product.name
            productPrice.text = String(product.price)
        }
        
    }
    
    //buyButton
    
   

}

