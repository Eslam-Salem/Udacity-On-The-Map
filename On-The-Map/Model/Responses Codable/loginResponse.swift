//
//  loginResponse.swift
//  On-The-Map
//
//  Created by Eslam  on 4/6/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import Foundation


struct account : Codable {
    
    let registered : Bool
    let key : String
}

struct session : Codable {
    let id : String
    let expiration : String
}


struct loginResponse : Codable {
    let account : account
    let session : session
}
