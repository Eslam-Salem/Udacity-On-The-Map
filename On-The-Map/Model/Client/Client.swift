//
//  Client.swift
//  On-The-Map
//
//  Created by Eslam  on 4/10/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import Foundation



class client {
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, udacityApiFlag:Bool, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        
        var request = URLRequest(url: url)
        
        if udacityApiFlag == false {
            request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
            request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            //function used to send an error to completion with a specific message
            func sendError(_ error: String) {
                let userInfo = [NSLocalizedDescriptionKey : error]
                completion(nil, NSError(domain: "taskForGETRequest", code: 1, userInfo: userInfo))
            }
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                sendError("Request did not return a valid response.")
                return
            }
            
            switch (statusCode) {
            case 403:
                sendError("Please check your email and password")
            case 200 ..< 299:
                break
            default:
                sendError("Please try again later!!")
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    sendError("No Data returned with your Request. Try again!!")
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            let responseObject : Any
            do {
                if udacityApiFlag == true {
                    let range = (5..<data.count)
                    let newData = data.subdata(in: range)
                    responseObject = try decoder.decode(ResponseType.self, from: newData)
                }else {
                    responseObject = try decoder.decode(ResponseType.self, from: data)
                }
                DispatchQueue.main.async {
                    completion((responseObject as! ResponseType), nil)
                }
            } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                }
            }
        }
        task.resume()
        
        return task
    }
    
    
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, udacityApiFlag:Bool, body: RequestType,completion: @escaping (ResponseType?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        if udacityApiFlag == false {
            request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
            request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        } else {
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
           
            //function used to send an error to completion with a specific message
            func sendError(_ error: String) {
                let userInfo = [NSLocalizedDescriptionKey : error]
                completion(nil, NSError(domain: "taskForPostRequest", code: 1, userInfo: userInfo))
            }
            
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
      
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                sendError("Request did not return a valid response.")
                return
            }
            
            switch (statusCode) {
            case 403:
                sendError("Please check your email and password")
            case 200 ..< 299:
                break
            default:
                sendError("Please try again later")
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    sendError("No Data returned with your Request. Try again!!")
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            let responseObject : Any

            do {
                if udacityApiFlag == true {
                    let range = (5..<data.count)
                    let newData = data.subdata(in: range)
                    responseObject = try decoder.decode(ResponseType.self, from: newData)
                }else {
                    responseObject = try decoder.decode(ResponseType.self, from: data)
                }
                DispatchQueue.main.async {
                    completion((responseObject as! ResponseType), nil)
                }
            } catch {
                   DispatchQueue.main.async {
                        completion(nil, error)
                }
            }
        }
        task.resume()
    }
    
   
    
    
    
    
}
