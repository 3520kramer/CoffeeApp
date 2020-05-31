//
//  Product.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 14/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import Foundation

class Product{
  
    var id: String
    var name: String
    var price: Double
    var quantity: String
    var size: String
    
    // initializer when fetching from database
    init(id: String, name: String, price: Double, quantity: String, size: String){
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity
        self.size = size
    }

}
