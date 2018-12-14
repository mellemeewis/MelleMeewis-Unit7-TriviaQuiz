//
//  Question.swift
//  TriviaQuiz
//
//  Created by Melle Meewis on 11/12/2018.
//  Copyright © 2018 Melle Meewis. All rights reserved.
//

import Foundation

struct Question: Codable {
    var category: String
    var type: String
    var difficulty: String
    var question: String
    var correctAnswer: String
    var incorrectAnswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case category
        case type
        case difficulty
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}

struct Questions: Codable {
    let responseCode: Int
    let questions: [Question]
    
    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case questions = "results"
    }
}
