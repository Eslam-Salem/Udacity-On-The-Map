//
//  parseClient.swift
//  On-The-Map
//
//  Created by Eslam  on 4/17/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import Foundation

// this class contains all parse api actions

class parseClient {
    
    class func getStudentsLocation(completion: @escaping ([student], Error?) -> Void){
        
        client.taskForGETRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation?limit=100&order=-updatedAt")!, responseType: getUserLocationResponse.self, udacityApiFlag: false) { (responseType, error) in
            if let responseType = responseType {
                completion(responseType.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    //****************************
    class func addLocation (mapString: String, mediaUrl: String, latitude: Double, longitude: Double, completion: @escaping (Bool, Error?) -> Void){
        
        let body = addStudentRequest(latitude: latitude, longitude: longitude, mapString: mapString, mediaURL: mediaUrl)
        
        client.taskForPOSTRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!, responseType: addStudentResponse.self, udacityApiFlag: false, body: body) { (responseType, error) in
            if responseType != nil {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
}
