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
    
    func fetchQuestions(forUserInput userInput: [String: String], completion: @escaping ([Question]?) -> Void) {
        let baseURL = URL(string: "https://opentdb.com/api.php?")!
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        components.queryItems = []
        for (key, value) in userInput {
            components.queryItems?.append(URLQueryItem(name: key, value: value))
        }
        let questionURL = components.url!
        print(questionURL)
        let task = URLSession.shared.dataTask(with: questionURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data, let Questions = try? jsonDecoder.decode(Questions.self, from: data) {
                completion(Questions.questions)
            }
            else {
                completion(nil)
            }
        }
        task.resume()
    }
}
