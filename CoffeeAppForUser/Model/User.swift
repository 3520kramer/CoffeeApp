//
//  User.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 09/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import Foundation

class User{
    
    var id: String
    var firstName: String
    var lastName: String
    var username: String
    var password: String
    
    
    init(id: String, firstName: String, lastName: String, username: String, password: String){
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.password = password
    }
    
    
    
}
