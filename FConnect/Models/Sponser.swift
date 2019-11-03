//
//  Sponser.swift
//  FConnect
//
//  Created by hor kimleng on 11/3/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

import Foundation

struct Sponser {
    let contactPerson: String
    let description: String
    let emailPerson: String
    let numberPerson: String
    let titleSponsor: String
    let urlNews: String
    
    init(dictionary: [String: Any]) {
        self.contactPerson = dictionary["contactPerson"] as! String
        self.description = dictionary["description"] as! String
        self.emailPerson = dictionary["emailPerson"] as! String
        self.numberPerson = dictionary["numberPerson"] as! String
        self.titleSponsor = dictionary["titleSponsor"] as! String
        self.urlNews = dictionary["urlNews"] as! String
    }
}
