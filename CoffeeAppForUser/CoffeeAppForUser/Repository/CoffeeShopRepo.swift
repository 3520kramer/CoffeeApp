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
    private static let collectionName = "coffeeshop"
    
    static var coffeeShopList = [CoffeeShop]()
    
    static func startListener(vc:ViewControllerWithMap){
        db.collection(collectionName).addSnapshotListener { (snap, error) in
            if let snap = snap {
                
                self.coffeeShopList.removeAll()
                
                for doc in snap.documents{
                    let map = doc.data()
                    
                    let name = map["name"] as! String
                    let markerDescription = map["marker_description"] as! String
                    let geoPoint = map["coordinates"] as! GeoPoint
                    
                    
                    // FOR NOW THE SUBTITLE ON THE MARKER WILL BE THE DOC ID
                    // WE NEED TO FIX THIS LATER
                    let annotation = mapDataAdapter(id: doc.documentID, title: name, subtitle: doc.documentID, geoPoint: geoPoint)
                    
                    let coffeeShop = CoffeeShop(id: doc.documentID, name: name, marker: annotation)
                    
                    self.coffeeShopList.append(coffeeShop)
                }
                vc.updateMarkersOnMap()
            }
        }
    }
    
    // old way
    
    static func mapDataAdapter(id: String, title: String, subtitle: String, geoPoint: GeoPoint) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        
        annotation.title = title
        annotation.subtitle = subtitle
        annotation.coordinate = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
        
        return annotation
        
    }
    
    /* FOR CUSTOM ANNOTATION
    static func mapDataAdapter(id: String, title: String, subtitle: String, geoPoint: GeoPoint) -> CoffeeShopAnnotation {
        
        let coordinate = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
        
        let annotation = CoffeeShopAnnotation(coordinate: coordinate, name: title)
        
        return annotation
    }
    */
}
