//
//  LeaderBoardTableViewController.swift
//  TriviaQuiz
//
//  Created by Melle Meewis on 12/12/2018.
//  Copyright © 2018 Melle Meewis. All rights reserved.
//

import UIKit

class LeaderBoardTableViewController: UITableViewController {
    
    var newName: String = ""
    
    @IBAction func unwindToLeaderBoard(segue: UIStoryboardSegue) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        newName = ""
        GameController.shared.resetValues()
    }
    
    var highScores = [HighScore]()
    
    override func viewDidAppear(_ animated: Bool) {
        print("JAA")
        let highScores = HighScoreController.shared.fetchLeaderBoard()
        if let highScores = highScores {
            self.updateUI(with: highScores)
        }
    }

    func updateUI(with highScores: [HighScore]) {
        DispatchQueue.main.async {
            self.highScores = highScores.sorted {
                Int($1.score)! < Int($0.score)!
            }
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScores.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HighScoreCell", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let highScore = highScores[indexPath.row]
        cell.textLabel?.text = highScore.name
        if highScore.name == newName {
            cell.textLabel?.textColor = UIColor.blue
        }
        else {
            cell.textLabel?.textColor = UIColor.black
        }
        cell.detailTextLabel?.text = String(highScore.score)
        cell.setNeedsLayout()
    }
}
