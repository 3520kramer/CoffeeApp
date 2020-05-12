//
//  ViewControllerMenu.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 14/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import UIKit

class ViewControllerMenuForShop: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    var collectionID: String?
    var selectedProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if let id = collectionID{
            ProductRepo.startListener(id: id){ () -> () in
                self.tableView.reloadData()
                
            }
        }
    }
    
    //pass object to next viewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Yo")
        if let viewControllerInfo = segue.destination as? ViewControllerInfo{
            if let selectedProduct = selectedProduct{
                viewControllerInfo.product = selectedProduct
        
            }
        }
    }
}

extension ViewControllerMenuForShop: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductRepo.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = ProductRepo.productList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuTableProductCell
        
        
        cell.setCell(product: product)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = ProductRepo.productList[indexPath.row]
        performSegue(withIdentifier: "ShowInfo", sender: nil)
        print(selectedProduct?.name)
    }
    

}
       

