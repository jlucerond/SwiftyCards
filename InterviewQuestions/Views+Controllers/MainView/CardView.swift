//
//  CardView.swift
//  InterviewQuestions
//
//  Created by Joe Lucero on 5/1/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: UIView {
   
   @IBInspectable var startColor: UIColor = UIColor.lightGray
   @IBInspectable var endColor: UIColor = UIColor.darkGray
   
   let topLayerGradient = CAGradientLayer()
   private let topicLabel = UILabel()
   private let questionLabel = UILabel()
   private let questionCodeView = CodeView()
   private let answerLabel = UILabel()
   private let answerCodeView = CodeView()
   private let cornerRadius: CGFloat = 20.0
   private let spacingConstant: CGFloat = 20.0
   private let borderWidth: CGFloat = 3.0
   private let borderColor: UIColor = UIColor.black
   private(set) var isFrontOfCard: Bool = true
   
   var card: Card! {
      didSet {
         isFrontOfCard = true
         configure()
      }
   }
   
   // LifeCycle Methods
   override func awakeFromNib() {
      super.awakeFromNib()
      setUp()
   }
   
   override func prepareForInterfaceBuilder() {
      super.prepareForInterfaceBuilder()
      setUp()
      configureWithFakeDataForStoryboard()
      layoutSubviews()
   }
   
   // one time function to get the look of the card set-up correctly
   private func setUp() {
      layer.addSublayer(topLayerGradient)
      addSubview(topicLabel)
      addSubview(questionLabel)
      addSubview(questionCodeView)
      addSubview(answerLabel)
      addSubview(answerCodeView)
      
      layer.borderWidth = borderWidth
      layer.borderColor = borderColor.cgColor
      
      topLayerGradient.borderWidth = 3.0
      topLayerGradient.borderColor = borderColor.cgColor
      
      topicLabel.translatesAutoresizingMaskIntoConstraints = false
      questionLabel.translatesAutoresizingMaskIntoConstraints = false
      questionCodeView.translatesAutoresizingMaskIntoConstraints = false
      answerLabel.translatesAutoresizingMaskIntoConstraints = false
      answerCodeView.translatesAutoresizingMaskIntoConstraints = false
      
      topicLabel.font = UIFont(name: "Marker Felt", size: 25.0)
      topicLabel.adjustsFontSizeToFitWidth = true
      topicLabel.minimumScaleFactor = 0.1
      
      topLayerGradient.startPoint = CGPoint(x: 0, y: 0)
      topLayerGradient.endPoint = CGPoint(x: 0.5, y: 0.75)
      
      topicLabel.numberOfLines = 1
      questionLabel.numberOfLines = 0
      answerLabel.numberOfLines = 0
   }
   
   // sample set up for storyboard purposes
   private func configureWithFakeDataForStoryboard() {
      topLayerGradient.colors = [startColor.cgColor, endColor.cgColor]
      
      questionLabel.isHidden = isFrontOfCard ? false : true
      questionCodeView.isHidden = isFrontOfCard ? false : true
      answerLabel.isHidden = isFrontOfCard ? true : false
      answerCodeView.isHidden = isFrontOfCard ? true : false

      topicLabel.text = "Topic Label that is super extra long"
      questionLabel.text = "This is where the question will be"
      answerLabel.text = "This is where the answer will be"
      
      topicLabel.numberOfLines = 1
      questionLabel.numberOfLines = 0
      answerLabel.numberOfLines = 0
      
      layoutIfNeeded()
      setUpConstraints()
   }
   
   
   private func configure() {
      topLayerGradient.colors = [card.topGradientColor.cgColor, card.bottomGradientColor.cgColor]
      
      topicLabel.text = card.category
      questionLabel.text = card.question
      answerLabel.text = card.answer
      questionCodeView.codeText = card.questionCode ?? ""
      answerCodeView.codeText = card.answerCode ?? ""
      
      showOrHideText()
      
      layoutIfNeeded()
      setUpConstraints()
   }
   
   private func setUpConstraints() {
      topLayerGradient.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height * 0.1)
      topLayerGradient.cornerRadius = cornerRadius
      topLayerGradient.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
      
      self.layer.cornerRadius = cornerRadius
      self.clipsToBounds = true
      
      topicLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
      topicLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.9).isActive = true
      topicLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -(self.bounds.height - topLayerGradient.bounds.height)/2).isActive = true
      
      questionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topLayerGradient.bounds.height + spacingConstant).isActive = true
      questionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacingConstant).isActive = true
      questionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacingConstant).isActive = true

      questionCodeView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: spacingConstant).isActive = true
      questionCodeView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacingConstant).isActive = true
      questionCodeView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacingConstant).isActive = true
      
      answerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topLayerGradient.bounds.height + spacingConstant).isActive = true
      answerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacingConstant).isActive = true
      answerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacingConstant).isActive = true
      
      answerCodeView.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: spacingConstant).isActive = true
      answerCodeView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacingConstant).isActive = true
      answerCodeView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacingConstant).isActive = true
   }
   
   // Helper Methods
   func flipCard() {
      isFrontOfCard = !isFrontOfCard
      showOrHideText()
   }
   
   private func showOrHideText() {
      topicLabel.text = isFrontOfCard ? card.category : "Answer"
      questionLabel.isHidden = isFrontOfCard ? false : true
      questionCodeView.isHidden = (isFrontOfCard && !questionCodeView.codeText.isEmpty) ? false : true
      answerLabel.isHidden = !isFrontOfCard ? false : true
      answerCodeView.isHidden = (!isFrontOfCard && !answerCodeView.codeText.isEmpty) ? false : true
   }
   
}




