//
//  UdacityClient.swift
//  On-The-Map
//
//  Created by Eslam  on 4/6/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import Foundation
import UIKit

class UdacityClient: UIViewController {
    
    static var sessionId = ""
    static var userId = ""
    

//**************************************************************************************
    class func login (username :String ,password :String, completion: @escaping (Bool, Error?) -> Void){
 
        let body = loginRequest(username: username, password: password)

        client.taskForPOSTRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!, responseType: loginResponse.self, udacityApiFlag: true, body: body) { (responseType, error) in
            
            if let responseType = responseType {
                sessionId = responseType.session.id
                userId  = responseType.account.key
                completion(true, nil)
            } else {

                completion(false, error)
            }
        }
    }
    
    //****************************
    class func logout (completion: @escaping  () -> Void){
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            self.sessionId = ""
            completion()
        }
        task.resume()
    }
    
}
