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
}

extension ViewControllerMenuForShop: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductRepo.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = ProductRepo.productList[indexPath.row].name
        
        return cell
    }
    
}
