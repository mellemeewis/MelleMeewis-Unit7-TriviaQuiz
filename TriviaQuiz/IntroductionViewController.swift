//
//  IntroductionViewController.swift
//  TriviaQuiz
//
//  Created by Melle Meewis on 11/12/2018.
//  Copyright © 2018 Melle Meewis. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate  {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ _pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int {
        return categorieData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorieData[row]
    }
//
//    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        updateLabel()
//    }
    
    let categorieData = ["Any", "General Knowledge", "Books", "Films", "Music", "Musicals & Theatres", "Television", "Video Games", "Board Games", "Science & Nature", "Computers", "Mathematics", "Mythology", "Sports", "Geography", "History", "Politics", "Art", "Celebrities", "Animals", "Vehicles", "Comics", "Gadgets", "Japanese Anime & Manga", "Cartoon & Animations"]
    
    @IBAction func unwindToQuizIntroduction(segue: UIStoryboardSegue) {
        questions = []
        GameController.shared.resetValues()
    }
    
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var difficultyPicker: UISegmentedControl!
    @IBOutlet weak var amountOfQuestionsLabel: UILabel!
    @IBOutlet weak var amountOfQuestionsSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    var questions = [Question]()
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        var userInput: [String] = []
        let amountOfQuestions = String(Int(amountOfQuestionsSlider.value))
        userInput.append(amountOfQuestions)
        
        if categoryPicker.selectedRow(inComponent: 0) != 0 {
            userInput.append(String(categoryPicker.selectedRow(inComponent: 0) + 8))
        }
        
        let difficulty = difficultyPicker.titleForSegment(at: difficultyPicker.selectedSegmentIndex)?.lowercased()
        if difficulty != "any" {
            userInput.append(difficulty!)
        }
        print(userInput)

        
        
        GameController.shared.fetchQuestions(forUserInput: userInput as [String]){
            (questions) in
            if let questions = questions {
                self.questions = questions
                while questions.count < Int(self.amountOfQuestionsSlider.value)  {
                    continue
                }
                self.performSegue(withIdentifier: "PlayPressed", sender: nil)
            }
            else {
                self.performSegue(withIdentifier: "NotSupportedSegue", sender: nil)                
            }
        }
//        while questions.count < Int(amountOfQuestionsSlider.value)  {
//            continue
//        }
//        performSegue(withIdentifier: "PlayPressed", sender: nil)
    }
    
    @IBAction func AmountOfQuestionsSliderAltered(_ sender: UISlider) {
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.layer.cornerRadius = 5.0
        updateUI()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        let step: Float = 1
        let roundedValue = round(amountOfQuestionsSlider.value / step) * step
        amountOfQuestionsSlider.value = roundedValue
        amountOfQuestionsLabel.text = "\(String(Int(amountOfQuestionsSlider.value))) Questions"
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlayPressed" {
            let DestViewController = segue.destination as! UINavigationController
            let questionViewController = DestViewController.topViewController as! QuestionViewController
            questionViewController.questions = self.questions
        }
    }
}
