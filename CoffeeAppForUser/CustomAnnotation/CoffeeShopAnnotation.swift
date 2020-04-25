//
//  CoffeeShopAnnotation.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 16/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import Foundation
import MapKit

class CoffeeShopAnnotation: NSObject, MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var name: String

    init(coordinate: CLLocationCoordinate2D, name: String) {
        self.coordinate = coordinate
        self.name = name
    }
    
}
