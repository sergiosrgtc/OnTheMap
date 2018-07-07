//
//  StudentLocation.swift
//  OntheMap
//
//  Created by Sergio Costa on 28/06/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let feed = try Feed(json)

//   let studentLocation = try? JSONDecoder().decode(StudentLocation.self, from: jsonData)

import Foundation

struct StudentLocations: Codable {
    let studentLocations: [StudentLocation]
    
    enum CodingKeys: String, CodingKey {
        case studentLocations = "results"
    }
}

struct StudentLocation: Codable {
    var uniqueKey: String?
    var firstName: String?
    var lastName: String?
    var mapString: String?
    var mediaURL: String?
    var latitude: Double?
    var longitude: Double?
    var objectID: String?
    var createdAt: String?
    var updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case uniqueKey = "uniqueKey"
        case firstName = "firstName"
        case lastName = "lastName"
        case mapString = "mapString"
        case mediaURL = "mediaURL"
        case latitude = "latitude"
        case longitude = "longitude"
        case objectID = "objectId"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }
}
