//
//  addStudentRequest.swift
//  On-The-Map
//
//  Created by Eslam  on 4/17/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import Foundation

struct addStudentRequest : Codable{
   
    let uniqueKey : String = UdacityClient.userId
    let firstName :String = "test"
    let lastName  :String = "not complete"
    let latitude :Double
    let longitude :Double
    let mapString : String
    let mediaURL : String 
}
