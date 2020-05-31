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
    
    private static let db = Firestore.firestore()
    private static let collectionName = "coffeeshops"
    
    static var coffeeShopList = [CoffeeShop]()
    static var coffeeShopListSortedByLocation = [CoffeeShop]()
    
    static func startListener(vc:ViewControllerWithMap){
        db.collection(collectionName).addSnapshotListener { (snap, error) in
            if let snap = snap {
                
                self.coffeeShopList.removeAll()
                
                for doc in snap.documents{
                    let map = doc.data()
                    
                    let id = doc.documentID
                    let timeEstimateMin = map["time_estimate_min"] as? Int ?? 99
                    let timeEstimateMax = map["time_estimate_max"] as? Int ?? 99
                    let rating = map["rating"] as? Int ?? 99
                    let geoPoint = map["coordinates"] as? GeoPoint ?? GeoPoint(latitude: 0.00, longitude: 0.00)
                    
                    
                    
                    let annotation = mapDataAdapter(title: id, subtitle: doc.documentID, geoPoint: geoPoint)
                    
                    let coffeeShop = CoffeeShop(id: id, timeEstimateMin: timeEstimateMin, timeEstimateMax: timeEstimateMax, rating: rating, marker: annotation)
                    
                    self.coffeeShopList.append(coffeeShop)
                }
                vc.updateMarkersOnMap()
                
                // Makes the table update it's data after list is filled, otherwise we would have an empty table
                vc.tableWithNearbyShops.reloadData()
            }
        }
    }
    
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
