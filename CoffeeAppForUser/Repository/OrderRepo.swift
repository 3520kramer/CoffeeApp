//
//  OrderRepo.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 28/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import Foundation
import FirebaseFirestore
import MapKit

class OrderRepo{
    
    private static let db = Firestore.firestore()
    private static let collectionName = "orders"
    private static let subCollectionName = "products"
    
    static var orders = [Order]()
    
    //.whereField("", isEqualTo: username)
    
    static func startListener(vc:ViewControllerOrders, user_id: String){
        db.collection(collectionName).whereField("user_id", isEqualTo: user_id).addSnapshotListener { (snap, error) in
            if let snap = snap {
                
                self.orders.removeAll()
                
                for doc in snap.documents{
                    let map = doc.data()
                    
                    let id = doc.documentID
                    let date = map["date"] as! String
                    let time = map["time"] as? Int ?? 00
                    let total = map["total"] as! Double
                    let coffeeShopID = map["coffeeshop_id"] as? String ?? ""
                    let userID = map["user_id"] as? String ?? ""
                    let customerName = map["customer_name"] as? String ?? ""
                    let orderStatus = map["order_status"] as? Bool ?? false
                    let archived = map["archived_status"] as? Bool ?? false
                    let comments = map["comments"] as? String ?? ""
                    
                    // nested listener to fetch the products in the products subcollection
                    startListenerForProducts(id: id) { (productList) in
                        let products = productList
                        
                        let order = Order(id: id, date: date, time: time, total: total, coffeeShopID: coffeeShopID, userID: userID, customerName: customerName, orderStatus: orderStatus, comments: comments, archived: archived, products: products)
                        
                        self.orders.append(order)
                        
                        vc.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    
    
    static func startListenerForProducts(id: String, completion: @escaping ([Product])->()){
        var productList = [Product]()
        
        db.collection(collectionName).document(id).collection(subCollectionName).addSnapshotListener { (snap, error) in
            if let snap = snap{
                for doc in snap.documents{
                    let map = doc.data()
                    
                    let name = map["name"] as! String
                    let price = map["price"] as! Double
                    let quantity = map["quantity"] as? String ?? ""
                    let size = map["size"] as? String ?? ""
                    
                    let product = Product(id: doc.documentID, name: name, price: price, quantity: quantity, size: size)
                    productList.append(product)
                }
                completion(productList)
            }
        }
    }
    
    static func addOrder(order:Order){
        // creates the new document in the order collection
        let docRef = db.collection(collectionName).document()
        
        // creates a map which holds the data we wan't to push to the document in firestore
        var orderMap = [String:Any]()
        
        order.setDateAndTime()
        
        // fills the map
        orderMap["date"] = order.date
        orderMap["time"] = order.time
        orderMap["total"] = order.total
        orderMap["coffeeshop_id"] = order.coffeeShopID
        orderMap["user_id"] = order.userID
        orderMap["customer_name"] = order.customerName
        orderMap["order_status"] = order.orderStatus
        orderMap["comments"] = order.comments
        orderMap["archived_status"] = order.archived
        
        // adds it to the database
        docRef.setData(orderMap)
        
        // iterates over the product list in orders
        for product in order.products{
            // in the first iteration we add the sub collection and a new document in that subcollection
            // after the first iteration, we only create new documents in the subcollection
            let subDocRef = db.collection(collectionName).document(docRef.documentID).collection(subCollectionName).document()
            
            // creates a map which holds the data we wan't to push to the document in the subcollection in firestore
            var productMap = [String:Any]()
            
            // fills the map
            productMap["name"] = product.name
            productMap["price"] = product.price
            productMap["size"] = product.size
            productMap["quantity"] = product.quantity
            
            // adds it to the database
            subDocRef.setData(productMap)
        }
    }
}

