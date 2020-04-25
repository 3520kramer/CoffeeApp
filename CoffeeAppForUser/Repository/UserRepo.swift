//
//  FirebaseRepo.swift
//  CoffeeAppForUser
//
//  Created by Oliver Kramer on 09/04/2020.
//  Copyright © 2020 Kea. All rights reserved.
//

import Foundation

import FirebaseFirestore
import FirebaseStorage

class UserRepo{
    
    private static let db = Firestore.firestore() // creates the connection to firestore
    private static let userCollection = "users" // we save our collection name in a variable
    
    private static var userList = [User]() // the list of users from firestore

    // listens for changes and updates if changes are made to db
    // uses a completionhandler to make sure the list of users is full, before proceeding
    static func startListener(completion: @escaping () -> ()){
        print("starting listener")
        
        // snapshot listener creates a snapshot when function is called and each time the database is modified
        db.collection(userCollection).addSnapshotListener { (snap, error ) in
            if error == nil{
                self.userList.removeAll() // empties the list before filling it to avoid duplicates
                for user in snap!.documents {
                    let map = user.data() // creates a map to hold the data
                    
                    let firstName = map["firstname"] as! String
                    let lastName = map["lastname"] as! String
                    let username = map["username"] as! String
                    let password = map["password"] as! String

                    // creates an user object with the data from firestore
                    let userFromDb = User(id: user.documentID, firstName: firstName, lastName: lastName, username: username, password: password)
                    
                    // appends the user object to the list
                    self.userList.append(userFromDb)
                }
                completion() // tells the completion handler that we are out of the for loop and finished filling the list
            }
        }
    }
    
    // function that adds a user to the database
    // precondition - a user object needs to have been initialized
    static func addUser(user:User){
        let docRef = db.collection(userCollection).document() // creates a new document with an auto id
        
        // creates a map, with the data from the user object
        var map = [String:String]()
        
        map["firstname"] = user.firstName
        map["lastname"] = user.lastName
        map["username"] = user.username
        map["password"] = user.password
        
        // updates the document in the database with the user objects information
        docRef.setData(map)
    }
    
    // function that edits a user already in the database
    // precondition - a user object needs to have been initialized, and the user must be in the database, or else it will be created
    static func editUser(user:User){
        let docRef = db.collection(userCollection).document(user.id) // creates a reference to the document of the user in the database
        
        // creates a map, with the data from the user object
        var map = [String:String]()

        map["firstname"] = user.firstName
        map["lastname"] = user.lastName
        map["username"] = user.username
        map["password"] = user.password
        
        // updates the document in the database with the user objects information
        docRef.setData(map)
    }
    
    // function that deletes a user from the database
    // precondition - a user object needs to have been initialized, and the user must be in the database
    static func deleteUser(user:User){
        db.collection(userCollection).document(user.id).delete()
    }
}
