//
//  HighScoreController.swift
//  TriviaQuiz
//
//  Created by Melle Meewis on 12/12/2018.
//  Copyright © 2018 Melle Meewis. All rights reserved.
//

import Foundation

class HighScoreController {
    
    static let shared = HighScoreController()
    
    let baseURL = URL(string: "https://ide50-mellemeewis.cs50.io:8080")!
    
    func fetchLeaderBoard() -> [HighScore]? {
        let baseURL = URL(string: "https://ide50-mellemeewis.cs50.io:8080")!
        var returnHighScores = [HighScore]()
        let leaderBoardURL = baseURL.appendingPathComponent("leaderboard")
        print(leaderBoardURL)
        let task = URLSession.shared.dataTask(with: leaderBoardURL) { (data, response, err) in
            guard let data = data else { return }
            do {
                let highScores = try JSONDecoder().decode([HighScore].self, from: data)
                returnHighScores = highScores
                print(highScores)
            }
            catch let jsonErr {
                print("Error serializing json: ", jsonErr)
                return
            }
        }
        task.resume()
        while returnHighScores.isEmpty {
            continue
        }
        return returnHighScores
    }
    
    func submitHighScore(name: String, score: Int) {
        let url = URL(string: "https://ide50-mellemeewis.cs50.io:8080/leaderboard")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "name=\(name)&score=\(score)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        }
        task.resume()
    }
}


