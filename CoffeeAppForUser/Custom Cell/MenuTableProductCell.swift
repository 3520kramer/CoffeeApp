//
//  MenuTableProductCell.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 12/05/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import UIKit

class MenuTableProductCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Configures the cell data
    func setCell(product: Product){
        nameLabel.text = product.name
        
        let formatter: String
        
        // if-statement to check if the number contains relevant digits or not
        if (product.price - floor(product.price) > 0.01) {
            formatter = "%.1f" // allow one digit
        }else{
            formatter = "%.0f" // will not allow any digits
        }
        
        // sets the pricelabel in the correct format
        priceLabel.text = String(format: formatter, product.price)
    }

}
