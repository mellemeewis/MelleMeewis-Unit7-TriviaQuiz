//
//  question.swift
//  TriviaQuiz
//
//  Created by Melle Meewis on 11/12/2018.
//  Copyright © 2018 Melle Meewis. All rights reserved.
//

import Foundation

struct MenuItem: Codable {
    var id: Int
    var name: String
    var detailText: String
    var price: Double
    var category: String
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case detailText = "description"
        case price
        case category
        case imageURL = "image_url"
    }
}

struct menuItems: Codable {
    let items: [MenuItem]
}
