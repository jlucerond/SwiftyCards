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
                    category: String) {
      
      self.init(context: CoreDataStack.context)
      self.question = question
      self.questionCode = questionCode
      self.answer = answer
      self.answerCode = answerCode
      self.category = category
   }
   
   var averageScore: Double {
      if self.timesSeen == 0 {
         return 0
      } else {
         return Double(self.totalPoints) / Double(self.timesSeen)
      }
   }
}
