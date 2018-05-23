//
//  CardModel+Convenience.swift
//  InterviewQuestions
//
//  Created by Joe Lucero on 5/6/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import UIKit
import CoreData

extension Card {
   convenience init(question: String,
                    questionCode: String,
                    answer: String,
                    answerCode: String,
                    category: String,
                    cardPack: String) {
      
      self.init(context: CoreDataStack.context)
      self.question = question
      self.questionCode = questionCode
      self.answer = answer
      self.answerCode = answerCode
      self.category = category
      self.cardPack = cardPack
   }
   
   var averageScore: Double {
      if self.timesSeen == 0 {
         return 0
      } else {
         let score = Double(self.totalPoints) / Double(self.timesSeen)
         return score > 4 ? 4 : score
      }
   }
}

extension Card {
   var topGradientColor: UIColor {
      switch cardPack {
      case CardModelController.CardPack.programmingTheory.rawValue:
         return #colorLiteral(red: 0.5810584426, green: 0.1285524964, blue: 0.5745313764, alpha: 1)
      case CardModelController.CardPack.beginnerSwift.rawValue:
         return #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
      case CardModelController.CardPack.intermediateSwift.rawValue:
         return #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
      case CardModelController.CardPack.advancedSwift.rawValue:
         return #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
      default:
         return UIColor.lightGray
      }
   }
   
   var bottomGradientColor: UIColor {
      switch cardPack {
      case CardModelController.CardPack.programmingTheory.rawValue:
         return #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)
      case CardModelController.CardPack.beginnerSwift.rawValue:
         return #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
      case CardModelController.CardPack.intermediateSwift.rawValue:
         return #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
      case CardModelController.CardPack.advancedSwift.rawValue:
         return #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
      default:
         return UIColor.darkGray
      }
   }
}
