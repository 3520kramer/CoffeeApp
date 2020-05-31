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
    
    private static let db = Firestore.firestore()
    private static let collectionName = "coffeeshops"
    
    static var productList = [Product]()
    
    
    static func startListener(id: String, completion: @escaping ()->() ){
        db.collection("\(collectionName)/\(id)/products").addSnapshotListener { (snap, error) in
            if let snap = snap {
                productList.removeAll()
                
                for doc in snap.documents{
                    let map = doc.data()
                    
                    let name = map["name"] as? String ?? ""
                    let price = map["price"] as? Double ?? 00
                    let quantity = map["quantity"] as? String ?? ""
                    let size = map["size"] as? String ?? ""
                    
                                    
                    let product = Product(id: doc.documentID, name: name, price: price, quantity: quantity, size: size)
                    
                    productList.append(product)
                }
                completion()
            }
        }
    }
    
}
