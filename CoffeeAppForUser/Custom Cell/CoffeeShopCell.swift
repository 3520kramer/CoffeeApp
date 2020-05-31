//
//  CoffeeShopCell.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 07/05/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import UIKit
import MapKit

class CoffeeShopCell: UITableViewCell {

    @IBOutlet weak var logoView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeEstimateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setCell(vc: ViewControllerWithMap, coffeeshop: CoffeeShop){
        logoView.image = #imageLiteral(resourceName: "coffeeshop_logo_demo")
        nameLabel.text = coffeeshop.id
        timeEstimateLabel.text = "\(coffeeshop.timeEstimateMin) - \(coffeeshop.timeEstimateMax) minutes"
        ratingLabel.text = "\(coffeeshop.rating) / 5 stars"
        distanceLabel.text = calculateDistanceToCoffeeShop(vc: vc, coffeeShop: coffeeshop)
        
    }
    
    /*func formatDistance(distance: Double){
        // If statement to configure the right output
        if distance < 1000{
           let distanceRounded = (distance / 10).rounded(.down)*10
           return "\(distanceRounded) m"
           
        } else if distance < 10000{
           let distanceRounded = (distance / 100).rounded(.down)/10
           return "\(distanceRounded) km"
           
        } else {
           return nil
        }
    }*/
    func calculateDistanceToCoffeeShop(vc: ViewControllerWithMap, coffeeShop: CoffeeShop) -> String? {
        // guard statement to get if the user location is not unknown
        guard let userLocation = vc.locationManager.location else { return nil }
        
        // create a CLLocation from the coffeshops coordinates
        let coffeeShopLocation = CLLocation(latitude: coffeeShop.marker.coordinate.latitude, longitude: coffeeShop.marker.coordinate.longitude)
        
        // use the userlocation and the CLLoc
        let distance = userLocation.distance(from: coffeeShopLocation)
        
        // set the distance to the coffeshop object to be able to sort the list
        coffeeShop.distanceToUser = distance
        
        
        print("hey calculator")
        // If statement to configure the right output
        if distance < 1000{
            let distanceRounded = (distance / 10).rounded(.down)*10
            return "\(distanceRounded) m"
            
        } else if distance < 10000{
            let distanceRounded = (distance / 100).rounded(.down)/10
            return "\(distanceRounded) km"
            
        } else {
            return nil
        }
    }

    

    
}
