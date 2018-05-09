//
//  ViewController.swift
//  InterviewQuestions
//
//  Created by Joe Lucero on 5/1/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
   @IBOutlet weak var nextCard: CardView!
   @IBOutlet weak var topCard: CardView!
   @IBOutlet weak var topCardYConstraint: NSLayoutConstraint!
   @IBOutlet weak var greenCheck: UIImageView!
   @IBOutlet weak var redX: UIImageView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      topCard.card = CardModelController.shared.cards[0]
      nextCard.card = CardModelController.shared.cards[1]
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.topCardYConstraint.constant = -20
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      self.topCardYConstraint.constant = 0
      
      UIView.animate(withDuration: 1.0) {
         self.view.layoutIfNeeded()
      }
   }
   
   
   @IBAction func userSwipedOn(recognizer: UIPanGestureRecognizer) {
      let usersFingerLocation = recognizer.translation(in: self.view)
      guard let cardView = recognizer.view as? CardView else { return }
      
      // calculates how far the user has swiped left or right
      let offsetX = cardView.center.x - view.frame.midX
      let percentSwiped = offsetX/view.frame.midX
      
      // changes the card's location and angle
      let centerX = cardView.center.x + usersFingerLocation.x
      let centerY = view.frame.midY + (0.5 * abs(offsetX))
      cardView.center = CGPoint(x:centerX,
                                y:centerY)
      let angleToRotate = Measurement(value: (Double(percentSwiped * 10)), unit: UnitAngle.degrees)
      let radiansAngle = angleToRotate.converted(to: .radians).value
      cardView.transform = CGAffineTransform(rotationAngle: CGFloat(radiansAngle))
      
      // moves the green check or red x onto the screen
      if percentSwiped > 0 {
         redX.alpha = 0
         
         let actualPercent = percentSwiped > 1 ? 1.0 : percentSwiped
         greenCheck.alpha = abs(actualPercent)
         
         let endCenterX = view.bounds.width/2
         let startCenterX = view.bounds.width + greenCheck.bounds.width/2
         let distanceToTravel = startCenterX - endCenterX
         
         let centerX = endCenterX + ((1 - actualPercent) * distanceToTravel)
         let centerY = view.bounds.midY
         greenCheck.center = CGPoint(x: centerX, y: centerY)
         
      } else {
         greenCheck.alpha = 0
         
         let actualPercent = abs(percentSwiped) > 1 ? 1.0 : abs(percentSwiped)
         redX.alpha = abs(actualPercent)
         
         let endCenterX = view.bounds.width/2
         let startCenterX = -redX.bounds.width/2
         let distanceToTravel = startCenterX - endCenterX
         
         let centerX = endCenterX + ((1 - actualPercent) * distanceToTravel)
         let centerY = view.bounds.midY
         redX.center = CGPoint(x: centerX, y: centerY)
      }
      
      // resets the recognizer's translation
      recognizer.setTranslation(CGPoint.zero, in: self.view)
      
      if recognizer.state == .ended {
         
         if (percentSwiped > 0.7 || recognizer.velocity(in: cardView).x > 600) {
            swipeRight(cardView: cardView)
         } else if (percentSwiped < -0.7 || recognizer.velocity(in: cardView).x < -600) {
            swipeLeft(cardView: cardView)
         } else {
            returnToCenter(cardView: cardView)
         }
      }
      
   }
   
   @IBAction func userTappedOn(recognizer: UITapGestureRecognizer) {
      guard let cardView = recognizer.view as? CardView else { return }
      cardView.flipCard()
      
      UIView.transition(with: cardView, duration: 1.0, options: [.transitionFlipFromLeft], animations: nil, completion: nil)
   }
   
}

private extension ViewController {
   func returnToCenter(cardView: CardView) {
      UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
         let centerX = self.view.frame.midX
         let centerY = self.view.frame.midY
         cardView.center = CGPoint(x: centerX, y: centerY)
         cardView.transform = .identity
         
         self.redX.alpha = 0
         self.redX.center = CGPoint(x: (-0.5 * self.redX.bounds.width), y: self.view.center.y)
         self.greenCheck.alpha = 0
         self.greenCheck.center = CGPoint(x: self.view.bounds.width + (0.5 * self.greenCheck.bounds.width), y: self.view.center.y)
         
      }, completion: nil)
   }
   
   func swipeLeft(cardView: CardView) {
      UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear], animations: {
         
         self.redX.alpha = 0
         self.redX.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
         
         let centerX = self.view.center.x - self.view.frame.width
         let centerY = self.view.center.y + 0.5 * self.view.frame.width
         cardView.center = CGPoint(x: centerX, y: centerY)
         
         let angleToRotate = Measurement(value: -20, unit: UnitAngle.degrees)
         let radiansAngle = angleToRotate.converted(to: .radians).value
         
         cardView.transform = CGAffineTransform(rotationAngle: CGFloat(radiansAngle))
      }) { (_) in
         CardModelController.shared.userSaw(cardView.card, andGotCorrect: false)
         self.switchToNextCard()
      }
   }
   
   func swipeRight(cardView: CardView) {
      UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear], animations: {
         
         self.greenCheck.alpha = 0
         self.greenCheck.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
         
         let centerX = self.view.center.x + self.view.frame.width
         let centerY = self.view.center.y + 0.5 * self.view.frame.width
         cardView.center = CGPoint(x: centerX, y: centerY)
         
         let angleToRotate = Measurement(value: 20, unit: UnitAngle.degrees)
         let radiansAngle = angleToRotate.converted(to: .radians).value
         
         cardView.transform = CGAffineTransform(rotationAngle: CGFloat(radiansAngle))
      }) { (_) in
         CardModelController.shared.userSaw(cardView.card, andGotCorrect: true)
         self.switchToNextCard()
      }
   }
   
   func switchToNextCard() {
      // update the top card to what the next card looks like
      CATransaction.begin()
      CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
      self.topCard.card = self.nextCard.card
      topCard.layer.layoutSublayers()
      topCard.transform = .identity
      topCardYConstraint.constant = -20
      CATransaction.commit()
            
      // animate the top card sliding down
      UIView.animate(withDuration: 0.3) {
         self.topCardYConstraint.constant = 0
         self.view.layoutIfNeeded()
      }

      // get next card and place on bottom of screen
      let randomIndex = Int(arc4random_uniform(UInt32(CardModelController.shared.cards.count)))
      nextCard.card = CardModelController.shared.cards[randomIndex]
      
      greenCheck.alpha = 0
      greenCheck.center = CGPoint(x: (view.bounds.width + 0.5 * greenCheck.bounds.width), y: view.bounds.midY)
      redX.alpha = 0
      redX.center = CGPoint(x: (-0.5 * redX.bounds.width), y: view.bounds.midY)
   }
   
   
}
