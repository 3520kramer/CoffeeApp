//
//  ProductRepo.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 14/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import Foundation
import FirebaseFirestore
import MapKit

class ProductRepo{
    
    private static let db = Firestore.firestore() // initiates the connection to firestore
    private static let collectionName = "coffeeshops" // we save our collection name in a variable
    
    static var productList = [Product]() // the list of products from firestore
    
    // function that listens for changes in the db
    // we pass the id for the coffeeshop as an argument so we can query for the specific coffeshops products
    // uses a completion handler to let the caller know when we are finished iterating
    static func startListener(id: String, completion: @escaping ()->() ){
        // snapshot listener creates a snapshot each time the database is modified
        db.collection("\(collectionName)/\(id)/products").addSnapshotListener { (snap, error) in
            if let snap = snap {
                // empties the list before filling it to avoid duplicates
                productList.removeAll()
                
                 // iterates over the documents in the snapshot
                for doc in snap.documents{
                    
                    // creates a map to hold the data
                    let map = doc.data()
                    
                    // uses the map and document id to set the relevant constants
                    let name = map["name"] as? String ?? ""
                    let priceString = map["price"] as? String ?? "0"
                    let quantity = map["quantity"] as? String ?? ""
                    let size = map["size"] as? String ?? ""
                    
                    // casts the string to a double to be able to create the total price later
                    guard let price = Double(priceString) else {
                        print("Error getting price from Firebase")
                        return
                    }
                    
                    // creates a product object from the constants above
                    let product = Product(id: doc.documentID, name: name, price: price, quantity: quantity, size: size)
                    
                    // appends the coffeeshop to the list
                    productList.append(product)
                }
                // calls the completionhandler
                completion()
            }
        }
    }
    
}
