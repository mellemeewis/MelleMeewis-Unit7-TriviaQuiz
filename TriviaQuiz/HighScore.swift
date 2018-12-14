//
//  HighScore.swift
//  TriviaQuiz
//
//  Created by Melle Meewis on 12/12/2018.
//  Copyright © 2018 Melle Meewis. All rights reserved.
//

import Foundation

struct HighScore: Codable {
    var id: Int
    var name: String
    var score: String
    
    init(json: [String: Any]) {
        id = json["id"] as? Int ?? -1
        name = json["name"] as? String ?? ""
        score = json["score"] as? String ?? ""
    }
}


