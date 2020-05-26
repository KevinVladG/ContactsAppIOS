//
//  DataModels.swift
//  InClass09
//
//  Created by Kevin Granados on 4/5/20.
//  Copyright © 2020 Kevin Granados. All rights reserved.
//

import Foundation
import Firebase

//global vars
let rootRef = Database.database().reference()
var userID:String?
var newcontact:Contact?
var numContacts = [Contact]()

class Contact {
    var id:String?
    var name:String?
    var email:String?
    var phone:String?
    var phoneType:String?
    
    init(id: String, name: String, email:String, phone:String, phoneType:String) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.phoneType = phoneType
    }
}

