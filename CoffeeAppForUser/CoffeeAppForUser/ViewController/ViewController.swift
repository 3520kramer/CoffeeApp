//
//  ViewController.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 09/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var userList = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        UserRepo.startListener { () in
            
            if let user = self.userList.first{
                print(user.password)
                
            }
            //print("\(self.userList.first.id)")
        }
        
        
    }
    


}

