//
//  getUserLocationRequest.swift
//  On-The-Map
//
//  Created by Eslam  on 4/10/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import Foundation

struct student : Codable{
    let createdAt :String?
    let firstName :String?
    let lastName  :String?
    let latitude :Float?
    let longitude :Float?
    let mapString : String?
    let mediaURL : String?
    let objectId : String?
    let uniqueKey : String?
    let updatedAt : String?
}

struct getUserLocationResponse :Codable {

        let results : [student]
    
}
