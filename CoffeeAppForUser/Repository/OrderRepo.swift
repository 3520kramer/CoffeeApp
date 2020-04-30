//
//  OrderRepo.swift
//  CoffeeAppForUser
//
//  Created by Nadia Oubelaid on 28/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import Foundation
import FirebaseFirestore
import MapKit

class OrderRepo{
    
    private static let db = Firestore.firestore()
    private static let orderCollection = "orders"
    private static var orders = [Order]()
    
   
    static func addOrder(order:Order){
           let docRef = db.collection(orderCollection).document()
           
           var map = [String:String]()
            map["date"] = order.date
            map["time"] = order.time
            map["total"] = order.total
            docRef.setData(map)
       }
}

