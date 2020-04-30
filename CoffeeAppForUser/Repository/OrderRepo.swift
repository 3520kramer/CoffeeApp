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
    private static let productCollection = "products"
    private static var orders = [Order]()
    
    static func addOrder(order:Order){
        // creates the new document in the order collection
        let docRef = db.collection(orderCollection).document()
        
        // creates a map which holds the data we wan't to push to the document in firestore
        var orderMap = [String:Any]()
        
        // fills the map
        orderMap["date"] = order.date
        orderMap["time"] = order.time
        orderMap["total"] = order.total
        
        // adds it to the database
        docRef.setData(orderMap)
        
        // iterates over the product list in orders
        for product in order.products{
            // in the first iteration we add the sub collection and a new document in that subcollection
            // after the first iteration, we only create new documents in the subcollection
            let subDocRef = db.collection(orderCollection).document(docRef.documentID).collection(productCollection).document()
            
            // creates a map which holds the data we wan't to push to the document in the subcollection in firestore
            var productMap = [String:Any]()
            
            // fills the map
            productMap["name"] = product.name
            productMap["price"] = product.price
            
            // adds it to the database
            subDocRef.setData(productMap)
        }
        
    }
}

