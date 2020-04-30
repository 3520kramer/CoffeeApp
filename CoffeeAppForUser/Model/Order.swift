//
//  Order.swift
//  CoffeeAppForUser
//
//  Created by Nadia Oubelaid on 14/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import Foundation

class Order{
    
    var id: String? // we will not use this until we need to pull orders from the db
    var date: String?
    var time: String?
    var total: Double
    var customerEmail: String
    var products = [Product]()
    
    init(customerEmail: String) {
        self.customerEmail = customerEmail
        self.total = 00.00
    }
    
    // function which adds the product to the order and sets the new total
    func addProductToOrder(product: Product) {
        // appends the product to the list of products
        products.append(product)
        
        // adds the price of the products to the total of the order
        total += product.price
    }
    
    func setDateAndTime(){
        // Creates a Date object to find the date and time
        let currDate = Date.init()
        
        // Creates a dateformatter and changes format
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "HH:mm:ss"
        
        time = dateTimeFormatter.string(from: currDate)
        
        dateTimeFormatter.dateFormat = "dd/MM-yyyy"
        
        date = dateTimeFormatter.string(from: currDate)
        
    }
    
    
    
    /*
    //remove
    func delete(product item: Product){
        for (i, itemx) in items.enumerated(){
            if itemx.id == item.id {
                items.remove(at: i)
                print(itemx)
            }
        }
    }
    
    //count items in order
    func count() -> Int {
        var count: Int {
            items.count
        }
        return items.count
    }
    
    //total order price -->
    
    func totalOrderPrice (product item: Product) -> Double{
        var total = 00.00
        for _ in items{
            total += item.price
        }
        return total
        
      
        
    }
    
    
  */
    
    
    
    
    
    
    
}
