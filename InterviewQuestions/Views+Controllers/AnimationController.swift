//
//  AnimationController.swift
//  InterviewQuestions
//
//  Created by Joe Lucero on 5/12/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import Foundation
import UIKit

class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {
   
   private let duration = 1.0
   private var presenting = true
   
   func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
      return duration
   }
   
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      let containerView = transitionContext.containerView
      let toView = transitionContext.view(forKey: .to)!
      
      
      UIView.animate(
         withDuration: duration,
         delay:0.0,
         usingSpringWithDamping: 0.4,
         initialSpringVelocity: 0.0,
         animations: {

            // animations
         },
         completion: {_ in
            // completion handler
            transitionContext.completeTransition(true)
      })

   }
   
}
