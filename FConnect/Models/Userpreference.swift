//
//  Userpreference.swift
//  FConnect
//
//  Created by hor kimleng on 11/3/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

import Foundation

struct Userpreference {
    var descriptionNews: String
    let distanceNumber: String
    let titleNews: String
    let urlNews: String
    
    init(dictionary: [String: Any]) {
        self.descriptionNews = dictionary["descriptionNews"] as! String
        self.descriptionNews = self.descriptionNews.replacingOccurrences(of: "\\n", with: "\n")
        self.descriptionNews = self.descriptionNews.replacingOccurrences(of: "\\", with: "")
        self.distanceNumber = dictionary["distanceNumber"] as! String
        self.titleNews = dictionary["titleNews"] as! String
        self.urlNews = dictionary["urlNews"] as! String
    }
}
