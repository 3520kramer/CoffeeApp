//
//  CoffeeShopRepo.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 14/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import Foundation
import FirebaseFirestore
import MapKit

class CoffeeShopRepo{
    
    private static let db = Firestore.firestore() // initiates the connection to firestore
    private static let collectionName = "coffeeshops" // we save our collection name in a variable
    
    static var coffeeShopList = [CoffeeShop]() // the list of coffeeshops from firestore
    static var coffeeShopListSortedByLocation = [CoffeeShop]() // the sorted list of coffeeshops from firestore
    
    // function that listens for changes in the db
    // the viewcontroller is passed as argument so we can make changes to it from the function
    static func startListener(parentVC:ViewControllerWithMap){
        
        // snapshot listener creates a snapshot each time the database is modified
        db.collection(collectionName).addSnapshotListener { (snap, error) in
            if let snap = snap {
                
                // empties the list before filling it to avoid duplicates
                self.coffeeShopList.removeAll()
                
                // iterates over the documents in the snapshot
                for doc in snap.documents{
                    
                    // creates a map to hold the data
                    let map = doc.data()
                    
                    // uses the map and document id to set the relevant constants
                    let id = doc.documentID
                    let timeEstimateMin = map["time_estimate_min"] as? Int ?? 99
                    let timeEstimateMax = map["time_estimate_max"] as? Int ?? 99
                    let rating = map["rating"] as? Int ?? 99
                    let geoPoint = map["coordinates"] as? GeoPoint ?? GeoPoint(latitude: 0.00, longitude: 0.00)
                    
                    // calls the function mapDataAdapter which returns an annotation. The annotation can be displayes on a MapView
                    let annotation = mapDataAdapter(title: id, subtitle: doc.documentID, geoPoint: geoPoint)
                    
                    // creates a coffeeshop object from the constants above
                    let coffeeShop = CoffeeShop(id: id, timeEstimateMin: timeEstimateMin, timeEstimateMax: timeEstimateMax, rating: rating, marker: annotation)
                    
                    // appends the coffeeshop to the list
                    self.coffeeShopList.append(coffeeShop)
                }
                
                // as the iteration is finished we call a function from the parentVC to update the annotations on the map
                parentVC.updateMarkersOnMap()
                
                // Makes the table update it's data after list is filled, otherwise we would have an empty table
                parentVC.tableWithNearbyShops.reloadData()
            }
        }
    }
    
    // converts the data from firestore to an MKPointAnnotation to put on the map
    static func mapDataAdapter(title: String, subtitle: String, geoPoint: GeoPoint) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        
        annotation.title = title
        annotation.subtitle = subtitle
        annotation.coordinate = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
        
        return annotation
        
    }
    
    // Find a coffeeshop based on a name/id
    static func getCoffeeShop(with name: String) -> CoffeeShop?{
        
        for shop in coffeeShopList{
            if shop.id == name{
                return shop
            }
        }
        return nil
    }
}
