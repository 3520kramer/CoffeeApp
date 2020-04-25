//
//  Order.swift
//  CoffeeAppForUser
//
//  Created by Nadia Oubelaid on 14/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import Foundation

class Order{
    
    var orderId: String?
    var productQty: Int?
    var date: datum?
    var time: timeb?
    var totalAmount: Double?
    
    init() {
        
    }
    
    
    
    var items = [Product]()
    
    //append
    func add(product item: Product) {
        self.items.append(item)
        print(item.name)
    }
    
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
    
    
    
    
    
    
    
    
    
    
}
