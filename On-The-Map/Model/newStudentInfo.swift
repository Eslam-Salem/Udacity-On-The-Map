//
//  newStudentInfo.swift
//  On-The-Map
//
//  Created by Eslam  on 4/17/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import Foundation

struct newStudentInfo {
    // here i add new student data to pass it to the db 
    static var uniqueKey : String = UdacityClient.userId
    static var firstName :String = "no First Name"
    static var lastName  :String = "No last NAme"
    static var latitude :Double = 0.0
    static var longitude :Double = 0.0
    static var mapString : String = ""
    static var mediaURL : String = ""
}
