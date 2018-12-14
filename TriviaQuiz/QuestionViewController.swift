//
//  QuestionViewController.swift
//  TriviaQuiz
//
//  Created by Melle Meewis on 11/12/2018.
//  Copyright © 2018 Melle Meewis. All rights reserved.
//

import UIKit
import HTMLString

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel1: UIButton!
    @IBOutlet weak var answerLabel2: UIButton!
    @IBOutlet weak var extraAnswersStackView: UIStackView!
    @IBOutlet weak var answerLabel3: UIButton!
    @IBOutlet weak var answerLabel4: UIButton!
    
    @IBAction func AnswerButtonPressed(_ sender: UIButton) {
        
        if sender.title(for: .normal) == questions[questionIndex].correctAnswer {
            switch questions[questionIndex].difficulty {
            case "easy":
                GameController.shared.scoreEasyQuestions += 1
            case "medium":
                GameController.shared.scoreMediumQuestions += 2
            case "hard":
                GameController.shared.scoreHardQuestions += 3
            default:
                return
            }
        }
        nextQuestion()
    }
    
    
    
    var questions = [Question]()
    var questionIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        answerLabel1.layer.cornerRadius = 5.0
        answerLabel2.layer.cornerRadius = 5.0
        answerLabel3.layer.cornerRadius = 5.0
        answerLabel4.layer.cornerRadius = 5.0
        updateUI()
    }
    
    func updateUI() {
        let currentQuestion = questions[questionIndex]
        title = currentQuestion.category
        questionLabel.text = currentQuestion.question.removingHTMLEntities
        var allAnswers = currentQuestion.incorrectAnswers
        allAnswers.append(currentQuestion.correctAnswer)
        if currentQuestion.type == "boolean" {
            extraAnswersStackView.isHidden = true
            let number = Int.random(in: 0 ..< 2)
            answerLabel1.setTitle(allAnswers[number].removingHTMLEntities, for: .normal)
            answerLabel2.setTitle(allAnswers[1 - number].removingHTMLEntities, for: .normal)
        }
        else {
            extraAnswersStackView.isHidden = false
            var number = Int.random(in: 0 ..< 4)
            answerLabel1.setTitle(allAnswers[number].removingHTMLEntities, for: .normal)
            allAnswers.remove(at: number)
            number = Int.random(in: 0 ..< 3)
            answerLabel2.setTitle(allAnswers[number].removingHTMLEntities, for: .normal)
            allAnswers.remove(at: number)
            number = Int.random(in: 0 ..< 2)
            answerLabel3.setTitle(allAnswers[number].removingHTMLEntities, for: .normal)
            allAnswers.remove(at: number)
            answerLabel4.setTitle(allAnswers[0].removingHTMLEntities, for: .normal)
        }
        
        switch currentQuestion.difficulty {
        case "easy":
            GameController.shared.easyQuestions += 1
        case "medium":
            GameController.shared.mediumQuestions += 1
        case "hard":
            GameController.shared.hardQuestions += 1
        default:
            return
        }
    }
    
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
        }
        else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
}
