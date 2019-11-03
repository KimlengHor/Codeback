//
//  User.swift
//  FConnect
//
//  Created by hor kimleng on 11/3/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

import Foundation

struct User {
    let addressUser: String
    let distanceNumber: String
    let firstName: String
    let lastName: String
    let paypallAcc: String
    let questionAnswer: [Any]
    
    init(dictionary: [String: Any]) {
        self.addressUser = dictionary["addressUser"] as! String
        self.distanceNumber = dictionary["distanceNumber"] as! String
        self.firstName = dictionary["firstName"] as! String
        self.lastName = dictionary["lastName"] as! String
        self.paypallAcc = dictionary["paypallAcc"] as! String
        self.questionAnswer = dictionary["questionAnswer"] as! [Any]
    }
}
