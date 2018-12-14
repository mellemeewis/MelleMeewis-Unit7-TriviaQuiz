//
//  ResultsViewController.swift
//  TriviaQuiz
//
//  Created by Melle Meewis on 12/12/2018.
//  Copyright © 2018 Melle Meewis. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    let score = GameController.shared.scoreEasyQuestions + GameController.shared.scoreMediumQuestions + GameController.shared.scoreHardQuestions

    let easyScore = GameController.shared.scoreEasyQuestions
    let mediumScore = GameController.shared.scoreMediumQuestions
    let hardScore = GameController.shared.scoreHardQuestions
    
    let easyQuestions = GameController.shared.easyQuestions
    let mediumQuestions = GameController.shared.mediumQuestions
    let hardQuestions = GameController.shared.hardQuestions

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var easyScoreLabel: UILabel!
    @IBOutlet weak var mediumScoreLabel: UILabel!
    @IBOutlet weak var hardScoreLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func nameTextFieldEdited(_ sender: UITextField) {
        if sender.text != "" {
            submitButton.isEnabled = true
        }
        updateUI()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        HighScoreController.shared.submitHighScore(name: nameTextField.text!, score: score)
    }
    
    
    func updateUI() {
        if submitButton.isEnabled {
            submitButton.backgroundColor = playAgainButton.backgroundColor
        }
        else {
            submitButton.backgroundColor = UIColor.gray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.isEnabled = false
        submitButton.layer.cornerRadius = 5.0
        playAgainButton.layer.cornerRadius = 5.0
        
        navigationItem.hidesBackButton = true
        easyScoreLabel.isHidden = true
        mediumScoreLabel.isHidden = true
        hardScoreLabel.isHidden = true
        
        scoreLabel.text = "Well done! Your total score is \(String(score))!"
        
        if easyQuestions != 0 {
            easyScoreLabel.isHidden = false
            easyScoreLabel.text = "You answered \(String(easyScore)) out of \(easyQuestions) easy questions correct! \n Score: \(easyScore)"
        }
        
        if mediumQuestions != 0 {
            mediumScoreLabel.isHidden = false
            mediumScoreLabel.text = "You answered \(String(mediumScore / 2)) out of \(mediumQuestions) medium questions correct! \n Score: \(mediumScore)"
        }
        
        if hardQuestions != 0 {
            hardScoreLabel.isHidden = false
            hardScoreLabel.text = "You answered \(String(hardScore / 3)) out of \(hardQuestions) hard questions correct! \n Score: \(hardScore)"
        }
        updateUI()
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindToLeaderBoardSegue" {
            let leaderBoardViewController = segue.destination as! LeaderBoardTableViewController
            leaderBoardViewController.newName = nameTextField.text!
        }
    }
}
