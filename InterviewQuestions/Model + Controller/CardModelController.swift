//
//  CardModelController.swift
//  InterviewQuestions
//
//  Created by Joe Lucero on 5/6/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import Foundation
import CoreData

class CardModelController {
   
   // MARK: - When adding new Card Packs, make sure to include changes in MenuViewController (updating collection view) & CardModel+Convenience (updating colors)
   enum CardPack: String {
      case programmingTheory = "ProgrammingTheory"
      case beginnerSwift = "BeginnerSwift"
      case beginnerSwift2 = "BeginnerSwift2"
      case intermediateSwift = "IntermediateSwift"
      case intermediateSwift2 = "IntermediateSwift2"
      case advancedSwift = "AdvancedSwift"
      case advancedSwift2 = "AdvancedSwift2"

      case noCardPackFound = "Error"
//      case CoreData
//      case Networking
//      case CloudKit
//      case BeginnerObjC
//      case IntermediateObjC
//      case AdvancedObjC
//      case AutoLayout
//      case MapKit
//      case Animations
//      case DataStructures
//      case DesignPatterns
//      case WatchOS
   }
   
   static let shared = CardModelController()
   private(set) var cards: [Card] = []
   private var timePassed = 0
   private var timer: Timer!
   
   var usersTopPossibleScore: Double {
      return Double(cards.count * 4)
   }
   
   var usersCurrentScore: Double {
      return cards.reduce(0){
         $0 + $1.averageScore
      }
   }
   
   func restartTimer() {
      timePassed = 0
   }
   
   func userSaw(_ card: Card, andGotCorrect correct: Bool) {
      card.timesSeen += 1
      card.lastTimeSeen = Date()
      
      if correct {
         calculateNewScoreFor(card)
      }
      
      timePassed = 0
      
      save()
   }
   
   private init() {
      self.cards = loadCards()
      timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
         self.timePassed += 1
      })
   }
   
   private func save() {
      if CoreDataStack.context.hasChanges {
         do {
            try CoreDataStack.context.save()
         } catch let savingError {
            print("Error saving to Core Data: \(savingError.localizedDescription)")
         }
      }
   }
   
   private func loadCards() -> [Card] {
      let request: NSFetchRequest<Card> = Card.fetchRequest()
      let numberOfObjects = (try? CoreDataStack.context.count(for: request)) ?? 0
      
      if numberOfObjects == 0 {
         // loading things for the first time
         print("loading things the first time (create)")
         let programmingTheoryCards = loadCardsFromJSON(cardPack: .programmingTheory)
         let beginnerSwiftCards = loadCardsFromJSON(cardPack: .beginnerSwift)
         let intermediateSwiftCards = loadCardsFromJSON(cardPack: .intermediateSwift)
         let advancedSwiftCards = loadCardsFromJSON(cardPack: .advancedSwift)
         
         // FIXME: - Set this back to 3 decks before publishing
         return programmingTheoryCards + beginnerSwiftCards + intermediateSwiftCards + advancedSwiftCards
      } else {
         print("loading things from Core Data (find)")
         do {
            return try CoreDataStack.context.fetch(request)
         } catch let loadingError {
            print("Error loading from Core Data: \(loadingError.localizedDescription)")
            return []
         }
      }
   }
   
   private func loadCardsFromJSON(cardPack: CardModelController.CardPack) -> [Card] {
      guard let jsonURL = Bundle.main.url(forResource: cardPack.rawValue, withExtension: "json") else {
         print("Could not find that URL")
         return []
      }
      let jsonData = try! Data.init(contentsOf: jsonURL)
      
      let arrayOfDictionaries = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [[String:Any]]
      
      var arrayOfCards: [Card] = []
      for dictionary in arrayOfDictionaries {
         let question = dictionary["question"] as! String
         let questionCode = (dictionary["questionCode"] as? String) ?? ""
         let answer = dictionary["answer"] as! String
         let answerCode = (dictionary["answerCode"] as? String) ?? ""
         let category = dictionary["category"] as! String
         
         let newCard = Card(question: question, questionCode: questionCode, answer: answer, answerCode: answerCode, category: category, cardPack: cardPack.rawValue)
         arrayOfCards.append(newCard)
      }
      
      print("\(arrayOfCards.count) cards added to \(cardPack.rawValue) deck")
      return arrayOfCards
   }
   
   private func calculateNewScoreFor(_ card: Card) {
      if timePassed < 5 {
         card.totalPoints += 5
      } else if timePassed < 10 {
         card.totalPoints += 4
      } else if timePassed < 15 {
         card.totalPoints += 3
      } else if timePassed < 20 {
         card.totalPoints += 2
      } else {
         card.totalPoints += 1
      }
   }
}

