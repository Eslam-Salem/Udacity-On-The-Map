//
//  loginRequest.swift
//  On-The-Map
//
//  Created by Eslam  on 4/10/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import Foundation

struct userInformation : Codable {
    
    let email : String
    let password : String
}

struct loginRequest : Codable {
    
    var udacity = [String : String] ()

    init (username: String ,password: String)
    {
         udacity = ["username" : username , "password" : password]
    }

}
