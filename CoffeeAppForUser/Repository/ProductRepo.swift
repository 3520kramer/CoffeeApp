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
    private static let collectionName = "coffeeshop"
    
    static var productList = [Product]()
    
    
    static func startListener(id: String, completion: @escaping ()->() ){
        db.collection("\(collectionName)/\(id)/menu").addSnapshotListener { (snap, error) in
            if let snap = snap {
                productList.removeAll()
                
                for doc in snap.documents{
                    let map = doc.data()
                    
                    let name = map["name"] as! String
                    let price = map["price"] as! Double
                    
                    print("NAME: \(name)")
                    print("PRICE: \(price)")
                    
                    let product = Product(id: doc.documentID, name: name, price: price)
                    
                    productList.append(product)
                }
                completion()
            }
        }
    }
    
    // starts listening for products which are on the menu in the coffeeshop
    static func startListener2(vc:ViewControllerMenuForShop, id: String){
        // the path to the menu for each shop is collectionname/id/menu
        db.collection("\(collectionName)/\(id)/menu").addSnapshotListener { (snap, error) in
            if let snap = snap {
                productList.removeAll()
                
                for doc in snap.documents{
                    let map = doc.data()
                    
                    let name = map["name"] as! String
                    let price = map["price"] as! Double 
                    
                    print("NAME: \(name)")
                    print("PRICE: \(price)")
                    
                    let product = Product(id: doc.documentID, name: name, price: price)
                    
                    productList.append(product)
                }
                vc.tableView.reloadData()
            }
        }
    }
    
    
}
