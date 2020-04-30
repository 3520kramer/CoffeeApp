//
//  ViewControllerInfo.swift
//  CoffeeAppForUser
//
//  Created by Nadia Oubelaid on 28/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import UIKit

class ViewControllerInfo: UIViewController{
    
    @IBAction func buyButton(_ sender: Any) {
    }
    @IBOutlet weak var productDetail: UILabel!
    
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(product?.name)
        
        if let product = product {
            
        }
    }
    
    struct Storyboard {
        static let productnameCell = "ProductnameCell"
        
        
    }
}
extension ViewControllerInfo
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          // 0 Produkt navn
          // 1 pris
          // 2 køb knap 
          return 3
      }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = product?.name
        
        print (cell)
        return cell
        }

}

