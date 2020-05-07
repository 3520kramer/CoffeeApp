//
//  CoffeeShopCell.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 07/05/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import UIKit

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

    func setCell(coffeeshop: CoffeeShop){
        logoView.image = #imageLiteral(resourceName: "coffeeshop_logo_demo")
        nameLabel.text = coffeeshop.id
        timeEstimateLabel.text = "\(coffeeshop.timeEstimateMin) - \(coffeeshop.timeEstimateMax) minutes"
        ratingLabel.text = "\(coffeeshop.rating) / 5 stars"
        distanceLabel.text = "0.8 kilometers from you"
        
    }
}
