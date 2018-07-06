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
    var objectID: String?
    var latitude: Double?
    var mapString: String?
    var lastName: String?
    var uniqueKey: String?
    var firstName: String?
    var longitude: Double?
    var mediaURL: String?
    var createdAt: String?
    var updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case objectID = "objectId"
        case latitude = "latitude"
        case mapString = "mapString"
        case lastName = "lastName"
        case uniqueKey = "uniqueKey"
        case firstName = "firstName"
        case longitude = "longitude"
        case mediaURL = "mediaURL"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }
}
