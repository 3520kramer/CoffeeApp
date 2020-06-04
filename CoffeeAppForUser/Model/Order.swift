//
//  Order.swift
//  CoffeeAppForUser
//
//  Created by Nadia Oubelaid on 14/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import Foundation

class Order{
    
    var id: String?
    var date: String?
    var time: Int?
    var total: Double
    var coffeeShopID: String
    var userID: String
    var customerName: String
    var orderStatus: Bool
    var comments: String
    var archived: Bool?
    var products: [Product]
    
    // initializer for creating an order in the app
    init(userID: String, customerName: String, coffeeShopID: String) {
        self.total = 00.00
        self.coffeeShopID = coffeeShopID
        self.userID = userID
        self.customerName = customerName
        self.orderStatus = false
        self.comments = ""
        self.archived = false
        self.products = [Product]()
    }
    
    // initializer for creating order objects from the database
    init(id: String, date: String, time: Int, total: Double, coffeeShopID: String, userID: String, customerName: String, orderStatus: Bool, comments: String, archived: Bool, products: [Product]){
        self.id = id
        self.date = date
        self.time = time
        self.total = total
        self.coffeeShopID = coffeeShopID
        self.userID = userID
        self.customerName = customerName
        self.orderStatus = orderStatus
        self.comments = comments
        self.archived = archived
        self.products = products
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
        dateTimeFormatter.dateFormat = "HHmmss"
        
        time = Int(dateTimeFormatter.string(from: currDate))
        
        dateTimeFormatter.dateFormat = "dd/MM-yyyy"
        
        date = dateTimeFormatter.string(from: currDate)
        
    }
    
    // checks if the order has a comment
    func hasComment() -> Bool{
        if comments.isEmpty{
            return false
        }else{
            return true
        }
    }
}
