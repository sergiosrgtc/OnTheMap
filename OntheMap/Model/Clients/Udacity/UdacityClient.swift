//
//  UdacityClient.swift
//  OntheMap
//
//  Created by Sergio Costa on 28/06/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import Foundation

class UdacityClient : NSObject {
    
    // MARK: Shared Instance
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
    
    // shared session
    var session = URLSession.shared
    
    // create a URL from parameters
    func URLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil) -> URL {        
        var components = URLComponents()
        components.scheme = UdacityClient.Constants.ApiScheme
        components.host = UdacityClient.Constants.ApiHost
        components.path = UdacityClient.Constants.ApiPath + (withPathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
    }
    
    // MARK: GET
    func taskForGETMethod(_ method: String, parameters: [String:AnyObject], httpMethod: String = UdacityClient.HttpMethod.Get, completionHandlerForGET: @escaping (_ result: Data?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        /* 1. Set the parameters */
        var headers = [String:AnyObject]()
        headers[ParameterKeys.ApiKey] = Constants.RestApiKey as AnyObject?
        headers[ParameterKeys.ParseID] = Constants.ParseApiKey as AnyObject?

        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(url: URLFromParameters(parameters, withPathExtension: method))
        request.httpMethod = httpMethod
        
        for (key, value) in headers {
            request.setValue(value as? String, forHTTPHeaderField: key)
        }
        
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                var userInfo = ["":""]
                if error.description.contains("-1009"){
                    userInfo = [NSLocalizedDescriptionKey : "The Internet connection appears to be offline."]
                }else{
                    userInfo = [NSLocalizedDescriptionKey : error]
                }
                completionHandlerForGET(nil, NSError(domain: "taskForPostingSession", code: 1, userInfo: userInfo))
                return
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            completionHandlerForGET(data, nil)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    // MARK: GET
    func taskForPostingSession(email: String, password: String, httpMethod: String = UdacityClient.HttpMethod.Post, completionHandlerForGET: @escaping (_ result: Data?, _ error: NSError?) -> Void) -> URLSessionDataTask {

        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(url: URL(string: UdacityClient.Constants.AuthorizationURL)!)
        request.httpMethod = httpMethod
        
        request.addValue(UdacityClient.ParameterKeys.AppJson, forHTTPHeaderField: "Accept")
        request.addValue(UdacityClient.ParameterKeys.AppJson, forHTTPHeaderField: "Content-Type")
        
        request.httpBody = "{\"udacity\": {\"username\": \"\(email)\", \"password\": \"\(password)\"}}".data(using: .utf8)

        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                var userInfo = ["":""]
                if error.description.contains("-1009"){
                    userInfo = [NSLocalizedDescriptionKey : "The Internet connection appears to be offline."]
                }else{
                    userInfo = [NSLocalizedDescriptionKey : error]
                }
                completionHandlerForGET(nil, NSError(domain: "taskForPostingSession", code: 1, userInfo: userInfo))
                return
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            if let statusCode = (response as? HTTPURLResponse)?.statusCode{
                if statusCode == 403{
                    sendError("Wrong email or password!")
                    return
                }else if statusCode < 200 || statusCode > 299{
                    sendError("Request unsuscessfull")
                    return
                }
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            completionHandlerForGET(data, nil)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    
    // MARK: GET Convenience Methods
    
    func getStudentLocations(_ completionHandlerForGetStudentLocations: @escaping (_ result: StudentLocations?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = ["limit": "100"]
        let mutableMethod: String = Methods.StudentLocation
        
        /* 2. Make the request */
        let _ = taskForGETMethod(mutableMethod, parameters: parameters as [String:AnyObject]) { (results, error) in
            
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
        let _ = taskForPostingSession(email: email, password: password, httpMethod: UdacityClient.HttpMethod.Post) { (results, error) in
            
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
}
