//
//  currentUserResponse.swift
//  On-The-Map
//
//  Created by Eslam  on 5/4/19.
//  Copyright © 2019 Eslam. All rights reserved.
//

import Foundation

struct currentUserResponse: Codable{
    var lastName: String?
    var firstName: String?
    var nickName: String?
    
    enum CodingKeys: String, CodingKey{
        case lastName = "last_name"
        case firstName = "first_name"
        case nickName = "nickname"
    }
}
