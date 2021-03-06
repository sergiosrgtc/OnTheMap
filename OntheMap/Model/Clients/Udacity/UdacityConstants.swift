//
//  UdacityConstants.swift
//  OntheMap
//
//  Created by Sergio Costa on 28/06/18.
//  Copyright © 2018 Sergio Costa. All rights reserved.
//

import Foundation

extension UdacityClient {
    // MARK: Constants
    struct Constants {
        
        // MARK: API Key
        static let RestApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ParseApiKey = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"

        // MARK: URLs
        static let ApiScheme = "https"
        static let ApiHost = "parse.udacity.com"
        static let ApiPath = "/parse/classes"
        static let AuthorizationURL = "https://www.udacity.com/api/session"
    }
    
    // MARK: Methods
    struct HttpMethod{
        static let Get = "GET"
        static let Post = "POST"
        static let Put = "PUT"
        static let Delete = "DELETE"
    }
    struct Methods {
        static let StudentLocation = "/StudentLocation"
    }
    
    // MARK: URL Keys
    struct URLKeys {
        static let Limit = "limit"
    }
    
    // MARK: Parameter Keys
    struct ParameterKeys {
        static let ApiKey = "X-Parse-REST-API-Key"
        static let ParseID = "X-Parse-Application-Id"
        static let AppJson = "application/json"
    }
    
    // MARK: JSON Response Keys
    struct JSONResponseKeys {
        
        // MARK: General
        static let StatusMessage = "status_message"
        static let StatusCode = "status_code"
        
        // MARK: Authorization
        static let RequestToken = "request_token"
        static let SessionID = "session_id"
        
        // MARK: Account
        static let UserID = "id"
    }
}
