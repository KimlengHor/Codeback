//
//  Recruiters.swift
//  FConnect
//
//  Created by hor kimleng on 11/15/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

struct Recruiter {
    let companyName: String
    let email: String
    let linkedin: String
    let name: String
    
    init(dictionary: [String: Any]) {
        self.companyName = dictionary["companyName"] as! String
        self.email = dictionary["email"] as! String
        self.linkedin = dictionary["linkedin"] as! String
        self.name = dictionary["name"] as! String
    }
}
