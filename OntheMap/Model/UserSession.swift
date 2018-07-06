//
//  UserSession.swift
//  OntheMap
//
//  Created by Sergio Costa on 03/07/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import Foundation

struct UserSession: Codable {
    let account: Account
    let session: Session
    
    enum CodingKeys: String, CodingKey {
        case account = "account"
        case session = "session"
    }
}

struct Account: Codable {
    let registered: Bool
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case registered = "registered"
        case key = "key"
    }
}

struct Session: Codable {
    let id: String
    let expiration: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case expiration = "expiration"
    }
}
