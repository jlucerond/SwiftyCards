//
//  QuestionPackCollectionViewCell.swift
//  InterviewQuestions
//
//  Created by Joe Lucero on 5/22/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import UIKit

class QuestionPackCollectionViewCell: UICollectionViewCell {
   @IBOutlet weak var questionPackLabel: UILabel!
   @IBOutlet weak var percentCorrectLabel: UILabel!
   
   let backgroundLayer = CAGradientLayer()
   var questionPack: CardModelController.CardPack! {
      didSet {
         updateCell()
      }
   }
   private var cards: [Card] = []
   private var percentCorrect: Double {
      guard cards.count > 0 else { return 0 }
      var totalPoints = 0.0
      for card in cards {
         totalPoints += card.averageScore
      }
      return totalPoints/Double(cards.count * 4)
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      contentView.layer.addSublayer(backgroundLayer)
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.layer.addSublayer(backgroundLayer)
   }
   
   private func updateCell() {
      cards = []
      for card in CardModelController.shared.cards {
         if card.cardPack == questionPack.rawValue {
            cards.append(card)
         }
      }
      
      self.layer.cornerRadius = 10.0
      self.layer.masksToBounds = true
      self.backgroundColor = .white
      self.alpha = 1.0
      
      guard let card = cards.first else {
         questionPackLabel.text = questionPack.rawValue
         percentCorrectLabel.text = "Coming Soon!"
         setUpGradientWith(.lightGray, .black)
         self.alpha = 0.5

         return
      }
      
      questionPackLabel.text = card.category
      percentCorrectLabel.text = String(format: "%d%%", Int(100 * percentCorrect))
      setUpGradientWith(card.topGradientColor, card.bottomGradientColor)
   }
   
   private func setUpGradientWith(_ topGradientColor: UIColor, _ bottomGradientColor: UIColor) {
      backgroundLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
      backgroundLayer.frame = self.bounds
      backgroundLayer.startPoint = CGPoint(x: 0.5, y: 0)
      backgroundLayer.endPoint = CGPoint(x: 0.5, y: 1)
      backgroundLayer.locations = [NSNumber(value: 1 - percentCorrect - 0.05), NSNumber(value: 1 - percentCorrect + 0.05)]
      backgroundLayer.zPosition = -1
   }
}
