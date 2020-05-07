//
//  CoffeeShop.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 14/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import Foundation
import MapKit

class CoffeeShop{
    
    var name: String
    var timeEstimateMin: Int
    var timeEstimateMax: Int
    var rating: Int
    var marker: MKPointAnnotation
    
    /* FOR CUSTOM ANNOTATION
    var marker: CoffeeShopAnnotation
    */
    
    init(name: String, timeEstimateMin: Int, timeEstimateMax: Int, rating: Int, marker: MKPointAnnotation) {
        self.name = name
        self.timeEstimateMin = timeEstimateMin
        self.timeEstimateMax = timeEstimateMax
        self.rating = rating
        self.marker = marker
    }
    
    /* FOR CUSTOM ANNOTATION
    init(id: String, name: String, marker: CoffeeShopAnnotation) {
        self.id = id
        self.name = name
        self.marker = marker
    }
    */
}
