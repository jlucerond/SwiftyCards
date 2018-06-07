//
//  AddCardViewController.swift
//  InterviewQuestions
//
//  Created by Joe Lucero on 5/12/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController {
   
   @IBOutlet weak var redXButton: UIButton!
   @IBOutlet weak var greenCheckButton: UIButton!
   var backgroundGradientLayer: CAGradientLayer!
   @IBOutlet weak var categoryCIV: ContentInputView!
   @IBOutlet weak var questionCIV: ContentInputView!
   @IBOutlet weak var questionCodeCIV: ContentInputView!
   @IBOutlet weak var answerCIV: ContentInputView!
   @IBOutlet weak var answerCodeCIV: ContentInputView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      redXButton.layer.cornerRadius = 10.0
      greenCheckButton.layer.cornerRadius = 10.0
      
      redXButton.layer.borderColor = redXButton.backgroundColor!.withAlphaComponent(1).cgColor
      redXButton.layer.borderWidth = 2.0
      greenCheckButton.layer.borderColor = greenCheckButton.backgroundColor!.withAlphaComponent(1).cgColor
      greenCheckButton.layer.borderWidth = 2.0
      
      view.layer.masksToBounds = true
      view.layer.addSublayer(backgroundGradientLayer)
      
      backgroundGradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
      backgroundGradientLayer.masksToBounds = true
      backgroundGradientLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
      backgroundGradientLayer.zPosition = -1
   }
   
   @IBAction func backButtonPressed(_ sender: UIButton) {
      dismiss(animated: true, completion: nil)
   }
   
   @IBAction func saveButtonPressed(_ sender: UIButton) {
      guard let category = categoryCIV.userInput, !category.isEmpty, let question = questionCIV.userInput,
         !question.isEmpty, let questionCode = questionCodeCIV.userInput, let answer = answerCIV.userInput, let answerCode = answerCodeCIV.userInput else {
            showError()
            return
      }

      CardModelController.shared.createNewCard(question: question, questionCode: questionCode, answer: answer, answerCode: answerCode, category: category)
      dismiss(animated: true, completion: nil)
   }
   
   private func showError() {
      let alert = UIAlertController(title: "Oops", message: "It looks like you forgot to add something. Make sure that you include both a category and a question.", preferredStyle: .alert)
      
      let okAction = UIAlertAction(title: "Got it", style: .default, handler: nil)
      alert.addAction(okAction)
      
      present(alert, animated: true, completion: nil)
   }
   
   
}
