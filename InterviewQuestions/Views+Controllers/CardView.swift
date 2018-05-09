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
   
   // MARK: - fixme
   let topLayerGradient = CAGradientLayer()
   private let topicLabel = UILabel()
   private let questionLabel = UILabel()
   private let answerLabel = UILabel()
   private let cornerRadius: CGFloat = 20.0
   
   private var frontOfCard: Bool = true
   
   var card: Card! {
      didSet {
         frontOfCard = true
         configure()
         setNeedsLayout()
      }
   }

   func flipCard() {
      frontOfCard = !frontOfCard
      updateText()
   }
   
   private func updateText() {
      topicLabel.text = frontOfCard ? card.category : "Answer"
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
      configureWithFakeDataForStoryboard()
      layoutSubviews()
   }
   
   private func setUp() {
      layer.addSublayer(topLayerGradient)
      addSubview(topicLabel)
      addSubview(questionLabel)
      addSubview(answerLabel)
      
      layer.borderWidth = 3.0
      layer.borderColor = UIColor.black.cgColor
      
      topicLabel.translatesAutoresizingMaskIntoConstraints = false
      questionLabel.translatesAutoresizingMaskIntoConstraints = false
      answerLabel.translatesAutoresizingMaskIntoConstraints = false
      
      
      topicLabel.font = UIFont(name: "Marker Felt", size: 25.0)
      topicLabel.adjustsFontSizeToFitWidth = true
      topicLabel.minimumScaleFactor = 0.1
      
      topLayerGradient.startPoint = CGPoint(x: 0.5, y: 0.25)
      topLayerGradient.endPoint = CGPoint(x: 0.5, y: 0.75)
      
      topicLabel.numberOfLines = 1
      questionLabel.numberOfLines = 0
      answerLabel.numberOfLines = 0
   }
   
   private func configureWithFakeDataForStoryboard() {
      topLayerGradient.colors = [startColor.cgColor, endColor.cgColor]
      
      topicLabel.text = "Topic Label that is super extra long"
      
      questionLabel.isHidden = frontOfCard ? false : true
      answerLabel.isHidden = frontOfCard ? true : false

      questionLabel.text = "This is where the question will be"
      answerLabel.text = "This is where the answer will be"
      
      topicLabel.numberOfLines = 1
      questionLabel.numberOfLines = 0
      answerLabel.numberOfLines = 0
   }
   
   // make the call in a different place
   
   // add a timer
   
   private func configure() {
      topLayerGradient.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
      
      topicLabel.text = card.category
      questionLabel.text = card.question
      answerLabel.text = card.answer

      updateText()
      layer.setNeedsLayout()
      print("the layer needs to be laid out: \(layer.needsLayout())")
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      topLayerGradient.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height * 0.1)
      topLayerGradient.cornerRadius = cornerRadius
      topLayerGradient.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
      
      self.layer.cornerRadius = cornerRadius
      self.clipsToBounds = true
      
      topicLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
      topicLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: (topLayerGradient.bounds.height - topicLabel.bounds.height)/2).isActive = true
      topicLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.9).isActive = true
      
      questionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topLayerGradient.bounds.height + 20).isActive = true
      questionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
      questionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
      
      answerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topLayerGradient.bounds.height + 20).isActive = true
      answerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
      answerLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
   }
   
}

private extension CardView {
   var topGradientColor: UIColor {
      switch card.category {
      case "Beginner Swift":
         return UIColor.blue
      case "Intermediate Swift":
         return UIColor.orange
      default:
         return startColor
      }
   }
   
   var bottomGradientColor: UIColor {
      switch card.category {
      case "Beginner Swift":
         return UIColor.green
      case "Intermediate Swift":
         return UIColor.yellow
      default:
         return startColor
      }
   }
}


