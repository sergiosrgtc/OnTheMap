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
    static let sharedInstance = UdacityClient()
    
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
    
    func configureRequest(_ method: String?, parameters: [String:AnyObject], httpBody: Data?, httpMethod: String = UdacityClient.HttpMethod.Get) -> NSMutableURLRequest{
        /* 1. Set the parameters */
        
        var headers = [String:AnyObject]()
        headers[ParameterKeys.ApiKey] = Constants.RestApiKey as AnyObject?
        headers[ParameterKeys.ParseID] = Constants.ParseApiKey as AnyObject?
        
        let request: NSMutableURLRequest?
        if method != "" {
            request = NSMutableURLRequest(url: URLFromParameters(parameters, withPathExtension: method))
        }else{// Method is null, so is a login request
            request = NSMutableURLRequest(url: URL(string: UdacityClient.Constants.AuthorizationURL)!)
            request?.addValue(UdacityClient.ParameterKeys.AppJson, forHTTPHeaderField: "Accept")
        }
        
        if httpMethod == UdacityClient.HttpMethod.Post {
            request?.addValue(UdacityClient.ParameterKeys.AppJson, forHTTPHeaderField: "Content-Type")
        }
        request?.httpMethod = httpMethod
        
        for (key, value) in headers {
            request?.setValue(value as? String, forHTTPHeaderField: key)
        }
        if httpBody != nil{
            request?.httpBody = httpBody
        }
        return request!
    }
    
    // MARK: GET
    func taskForURLRequest(_ method: String, parameters: [String:AnyObject], httpBody: Data?, httpMethod: String = UdacityClient.HttpMethod.Get, completionHandlerForURLRequest: @escaping (_ result: Data?, _ error: NSError?) -> Void) -> URLSessionDataTask {

        /* 2/3. Build the URL, Configure the request */
        let request = configureRequest(method, parameters: parameters, httpBody: httpBody, httpMethod: httpMethod)
        
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                var userInfo = ["":""]
                if error.description.contains("-1009"){
                    userInfo = [NSLocalizedDescriptionKey : "The Internet connection appears to be offline."]
                }else{
                    userInfo = [NSLocalizedDescriptionKey : error]
                }
                completionHandlerForURLRequest(nil, NSError(domain: "taskForPostingSession", code: 1, userInfo: userInfo))
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
            completionHandlerForURLRequest(data, nil)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
}
