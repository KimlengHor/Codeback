//
//  Question.swift
//  FConnect
//
//  Created by hor kimleng on 11/15/19.
//  Copyright © 2019 kimlenghor. All rights reserved.
//

import Foundation

struct Question {
    let answer: String
    let question: String
    let keywords: [Any]
    
    init(dictionary: [String: Any]) {
        self.answer = dictionary["answer"] as! String
        self.question = dictionary["question"] as! String
        self.keywords = dictionary["keywords"] as! [Any]
    }
}
