//
//  UserLogin.swift
//  OntheMap
//
//  Created by Sergio Costa on 04/07/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import Foundation

import Foundation

class Userlogin: NSObject, Codable {
    let udacity: Udacity?
    
    override init() {
        udacity = Udacity()
    }
    
    enum CodingKeys: String, CodingKey {
        case udacity = "udacity"
    }
}

struct Udacity: Codable {
    var username: String?
    var password: String?
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case password = "password"
    }
}
