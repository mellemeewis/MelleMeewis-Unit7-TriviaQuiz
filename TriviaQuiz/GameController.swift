//
//  GameController.swift
//  TriviaQuiz
//
//  Created by Melle Meewis on 11/12/2018.
//  Copyright © 2018 Melle Meewis. All rights reserved.
//

import Foundation

class GameController {
    
    static let shared = GameController()
    
    var easyQuestions = 0
    var mediumQuestions = 0
    var hardQuestions = 0
    
    var scoreEasyQuestions = 0
    var scoreMediumQuestions = 0
    var scoreHardQuestions = 0
    
    func resetValues() {
        easyQuestions = 0
        mediumQuestions = 0
        hardQuestions = 0
        scoreEasyQuestions = 0
        scoreMediumQuestions = 0
        scoreHardQuestions = 0
    }
    
    func fetchQuestions(forUserInput userInput: [String], completion: @escaping ([Question]?) -> Void) {
        let baseURL = URL(string: "https://opentdb.com/api.php?")!
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "amount", value: userInput[0])]
        if userInput.count == 2 {
            if userInput[1].count > 2 {
                components.queryItems?.append(URLQueryItem(name: "difficulty", value: userInput[1]))
            }
            else {
                components.queryItems?.append(URLQueryItem(name: "category", value: userInput[1]))
            }
        }
        else if userInput.count == 3 {
            components.queryItems?.append(URLQueryItem(name: "category", value: userInput[1]))
            components.queryItems?.append(URLQueryItem(name: "difficulty", value: userInput[2]))
        }
        

        let questionURL = components.url!
        print(questionURL)
        let task = URLSession.shared.dataTask(with: questionURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let Questions = try? jsonDecoder.decode(Questions.self, from: data) {
                if Questions.questions.count > 0 {
                    completion(Questions.questions)
                } else {
                    completion(nil)
                }
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }
}
