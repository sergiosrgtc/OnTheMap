//
//  UdacityConvenienceRequests.swift
//  OntheMap
//
//  Created by Sergio Costa on 06/07/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import Foundation

extension UdacityClient{
    
    // MARK: GET Convenience Methods
    func getStudentLocations(_ completionHandlerForGetStudentLocations: @escaping (_ result: StudentLocations?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = ["limit": "100", "order":"-updatedAt"]
        let mutableMethod: String = Methods.StudentLocation
        
        /* 2. Make the request */
        let _ = taskForURLRequest(mutableMethod, parameters: parameters as [String:AnyObject], httpBody: nil) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForGetStudentLocations(nil, error)
            } else {
                let studentLocations = try? JSONDecoder().decode(StudentLocations.self, from: results!)
                
                if studentLocations != nil {
                    completionHandlerForGetStudentLocations(studentLocations, nil)
                } else {
                    completionHandlerForGetStudentLocations(nil, NSError(domain: "getFavoriteMovies parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getFavoriteMovies"]))
                }
            }
        }
    }
    
    func postSessionLogin(email: String, password: String, completionHandlerForPostSession: @escaping (_ result: UserSession?, _ error: NSError?) -> Void) {
        /* 2. Make the request */
        
        let httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        
        let _ = taskForURLRequest("", parameters: ["":"" as AnyObject], httpBody: httpBody, httpMethod: UdacityClient.HttpMethod.Post) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForPostSession(nil, error)
            } else {
                let range = Range(5..<results!.count)
                let newData = results?.subdata(in: range)
                
                let userSession = try? JSONDecoder().decode(UserSession.self, from: newData!)
                
                if userSession != nil {
                    completionHandlerForPostSession(userSession, nil)
                } else {
                    completionHandlerForPostSession(nil, NSError(domain: "Session parsing ", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse Session"]))
                }
            }
        }
    }
    
    func postStudentLocation(studentLocation: StudentLocation, completionHandlerForPostSession: @escaping (_ result: Bool?, _ error: NSError?) -> Void) {
        /* 2. Make the request */
        let mutableMethod: String = Methods.StudentLocation

        let httpBody = try? JSONEncoder().encode(studentLocation)
        print(String(data: httpBody!, encoding: .utf8)!)
        let _ = taskForURLRequest(mutableMethod, parameters: ["":"" as AnyObject], httpBody: httpBody, httpMethod: UdacityClient.HttpMethod.Post) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForPostSession(false, error)
            } else {
                print(String(data: results!, encoding: .utf8)!)
                completionHandlerForPostSession(true, nil)
            }
        }
    }
    
    func updateStudentLocation(studentLocation: StudentLocation, completionHandlerForPostSession: @escaping (_ result: Bool?, _ error: NSError?) -> Void) {
        /* 2. Make the request */
        
        let httpBody = try? JSONEncoder().encode(studentLocation)
        
        let _ = taskForURLRequest("", parameters: ["":"" as AnyObject], httpBody: httpBody, httpMethod: UdacityClient.HttpMethod.Put) { (results, error) in
            
            /* 3. Send the desired value(s) to completion handler */
            if let error = error {
                completionHandlerForPostSession(false, error)
            } else {
                print(String(data: results!, encoding: .utf8)!)
                completionHandlerForPostSession(true, nil)
            }
        }
    }
}
