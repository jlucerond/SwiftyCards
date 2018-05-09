//
//  CoreDataStack.swift
//  InterviewQuestions
//
//  Created by Joe Lucero on 5/6/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
   
   static let container: NSPersistentContainer = {
      
      let container = NSPersistentContainer(name: "CardModel")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
         if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
         }
      })
      return container
   }()
   
   static var context: NSManagedObjectContext {
      return container.viewContext
   }

}
