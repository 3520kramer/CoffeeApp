//
//  OrderCell.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 28/05/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import UIKit

class OrderCellWithoutComment: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var statusImageView: UIImageView!
    
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // cell initializer
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // behaviour for the cell if it is selected
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    // configures the cell
    func setCell(order: Order){
        nameLabel.text = order.coffeeShopID
        dateLabel.text = order.date
        statusLabel.text = determineOrderStatus(order: order)
        totalLabel.text = "\(formatNumber(number: order.total)) dkk"
        
        // gets the time from the order and makes it easier to read for the user
        if let time = order.time{
            let timeString = NSMutableString(string: String(time))
            timeString.insert(":", at: 4)
            timeString.insert(":", at: 2)

            timeLabel.text = String(timeString)
        }
        
        // Sets the number of lines for the productlabel to the number of products in the order
        productLabel.numberOfLines = order.products.count
        productLabel.text = ""
        
        priceLabel.numberOfLines = order.products.count
        priceLabel.text = ""
        
        // for each product we add it to the label on a new line
        for product in order.products{
            productLabel.text! += "\(product.name)\n"
            priceLabel.text! += "\(formatNumber(number: product.price)) dkk\n"
        }
        
        productLabel.sizeToFit()
        priceLabel.sizeToFit()
    }
    
    // function that determines the image and text of the order status depending on how far the order is in the process
    func determineOrderStatus(order: Order) -> String{
        
        if order.orderStatus == true && order.archived == false{
            
            // creates an UIImage with an icon
            if let myImage = UIImage(systemName: "smiley"){
                
                // makes the image able to change color
                let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                statusImageView.image = tintableImage
            }
            // sets the color of the image
            statusImageView.tintColor = .systemGreen
            
            // returns the text
            return "Order accepted"
            
        }else if order.orderStatus == true && order.archived == true{
            
            if let myImage = UIImage(systemName: "checkmark.circle"){
                let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                statusImageView.image = tintableImage
            }
            
            statusImageView.tintColor = .systemGreen

            return "Order picked up"
            
        }else if order.orderStatus == false && order.archived == true{
            
            if let myImage = UIImage(systemName: "xmark.circle"){
                let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                statusImageView.image = tintableImage
            }
            
            statusImageView.tintColor = .systemRed
            
            return "Order denied"
            
        }else if order.orderStatus == false{
            if let myImage = UIImage(systemName: "questionmark.circle"){
                let tintableImage = myImage.withRenderingMode(.alwaysTemplate)
                statusImageView.image = tintableImage
            }
            
            statusImageView.tintColor = .systemOrange
            
            return "Order waiting response"
        }else{
            return "n/a"
        }
    }
    
    // formats the number
    func formatNumber(number: Double) -> String {
        let formatter: String
        
        // if-statement to check if the number contains relevant digits or not
        if (number - floor(number) > 0.01) {
            formatter = "%.1f" // allow one digit
        }else{
            formatter = "%.0f" // will not allow any digits
        }
        
        // sets the pricelabel in the correct format
        return String(format: formatter, number)
    }
}

