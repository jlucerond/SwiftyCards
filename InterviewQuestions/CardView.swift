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
   
   @IBInspectable var startColor: UIColor = UIColor.white
   @IBInspectable var endColor: UIColor = UIColor.green
   private let topLayerGradient = CAGradientLayer()
   private let topicLabel = UILabel()
   private let questionLabel = UILabel()
   private let answerLabel = UILabel()
   private let cornerRadius: CGFloat = 20.0
   
   private var frontOfCard: Bool = true
   
   var currentTitle: String = "" {
      didSet {
         frontOfCard = true
         configure()
      }
   }
   
   // this function will check to see which side is showing, flip to the opposite side and decorate the view accordingly
   func flipCard() {
      frontOfCard = !frontOfCard
      updateText()
   }
   
   private func updateText() {
      topicLabel.text = frontOfCard ? "front of card" : "back of card"
      questionLabel.isHidden = frontOfCard ? false : true
      answerLabel.isHidden = frontOfCard ? true : false
   }
   
   override func awakeFromNib() {
      super.awakeFromNib()
      setUp()
   }
   
   override func prepareForInterfaceBuilder() {
      super.prepareForInterfaceBuilder()
      setUp()
      configure()
   }
   
   private func setUp() {
      layer.borderWidth = 3.0
      layer.borderColor = UIColor.black.cgColor
      
      layer.addSublayer(topLayerGradient)
      topicLabel.translatesAutoresizingMaskIntoConstraints = false
      questionLabel.translatesAutoresizingMaskIntoConstraints = false
      answerLabel.translatesAutoresizingMaskIntoConstraints = false
      
      addSubview(topicLabel)
      addSubview(questionLabel)
      addSubview(answerLabel)
   }
   
   private func configure() {
      topLayerGradient.colors = [startColor.cgColor, endColor.cgColor]
      topLayerGradient.startPoint = CGPoint(x: 0.5, y: 0.25)
      topLayerGradient.endPoint = CGPoint(x: 0.5, y: 0.75)
      
      topicLabel.text = currentTitle
      topicLabel.font = UIFont(name: "Marker Felt", size: 25.0)
      
      questionLabel.text = "This is the question"
      answerLabel.text = "This is the answer"
      
      updateText()
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      topLayerGradient.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height * 0.1)
      topLayerGradient.cornerRadius = cornerRadius
      topLayerGradient.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
      
      self.layer.cornerRadius = cornerRadius
      self.clipsToBounds = true
      
      topicLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
      topicLabel.centerYAnchor.constraint(equalTo: self.topAnchor, constant: (topLayerGradient.bounds.height - topicLabel.bounds.height)).isActive = true
      
      questionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topLayerGradient.bounds.height + 20).isActive = true
      questionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
      questionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
      
      answerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topLayerGradient.bounds.height + 20).isActive = true
      answerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
      answerLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
   }
   
}


