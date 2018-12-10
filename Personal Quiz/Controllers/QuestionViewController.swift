//
//  QuestionViewController.swift
//  Personal Quiz
//
//  Created by Denis Bystruev on 06/12/2018.
//  Copyright © 2018 Denis Bystruev. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet var rangedLabels: [UILabel]!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    // MARK: - Properties
    var questions: [Question] = [
        Question(text: "Что вы предпочитаете?", type: .single, answers: [
            Answer(text: "Мясо", type: .dog),
            Answer(text: "Рыбу", type: .cat),
            Answer(text: "Морковку", type: .rabbit),
            Answer(text: "Капусту", type: .turtle),
            ]),
        Question(text: "Какие виды деятельности любите?", type: .multiple, answers: [
            Answer(text: "Плавать", type: .turtle),
            Answer(text: "Спать", type: .cat),
            Answer(text: "Прыгать", type: .rabbit),
            Answer(text: "Грызть тапки", type: .dog),
            ]),
        Question(text: "Как вы относитесь к поездкам?", type: .ranged, answers: [
            Answer(text: "Ненавижу", type: .cat),
            Answer(text: "Они меня нервируют", type: .rabbit),
            Answer(text: "На замечаю", type: .turtle),
            Answer(text: "Обожаю", type: .dog),
            ]),
        ]
    
    var questionIndex = 0
    
    var answersChosen = [Answer]()
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Methods
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Вопрос № \(questionIndex + 1)"
        
        let question = questions[questionIndex]
        questionLabel.text = question.text
        
        let answers = question.answers
        
        let progress = Float(questionIndex) / Float(questions.count)
        progressView.progress = progress
        
        switch question.type {
        case .single:
            updateSingleStack(using: answers)
        case .multiple:
            updateMultipleStack(using: answers)
        case .ranged:
            updateRangedStack(using: answers)
        }
    }
    
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButtons.forEach { $0.isHidden = true }
        for index in 0..<min(singleButtons.count, answers.count) {
            singleButtons[index].isHidden = false
            singleButtons[index].setTitle(answers[index].text, for: .normal)
        }
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multipleLabels.forEach { $0.superview!.isHidden = true }
        for index in 0..<min(multipleLabels.count, answers.count) {
            multipleLabels[index].superview!.isHidden = false
            multipleLabels[index].text = answers[index].text
        }
    }

    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedLabels.first!.text = answers.first!.text
        rangedLabels.last!.text = answers.last!.text
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }

    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            
            resultsViewController.answers = answersChosen
        }
     }
    
   
    // MARK: - @IBAction
    @IBAction func singleButtonPressed(_ sender: UIButton) {
        let answers = questions[questionIndex].answers
        let index = singleButtons.index(of: sender)!
        answersChosen.append(answers[index])
        nextQuestion()
    }
    
    @IBAction func multipleButtonPressed() {
        let answers = questions[questionIndex].answers
        
        for index in 0..<min(multipleLabels.count, answers.count) {
            let label = multipleLabels[index]
            let stackView = label.superview!
            let multiSwitch = stackView.subviews.last! as! UISwitch
            
            if multiSwitch.isOn {
                answersChosen.append(answers[index])
            }
        }
        nextQuestion()
    }

    @IBAction func rangedButtonPressed() {
        let answers = questions[questionIndex].answers
        let index = Int(round(slider.value * Float(answers.count - 1)))
        answersChosen.append(answers[index])
        nextQuestion()
    }
}
