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
   
   private let duration = 2.0
   var isPresenting = true
   var buttonFrame: CGRect!
   var backgroundLayer: CAGradientLayer!
   
   func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
      print("button frame is: \(buttonFrame)")
      return duration
   }
   
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      let containerView = transitionContext.containerView
      let toView = transitionContext.view(forKey: .to)!
      let fromView = transitionContext.view(forKey: .from)!
      
      let mainView = isPresenting ? fromView : toView
      let detailView = isPresenting ? toView : fromView
      detailView.layer.borderColor = UIColor.black.cgColor
      detailView.layer.borderWidth = 3.0
            
      if isPresenting {
         animateToDetailVC(mainView: mainView,
                           detailView: detailView,
                           containerView: containerView) {
            transitionContext.completeTransition(true)
         }
      } else {
         animateBackToMainVC(mainView: mainView,
                             detailView: detailView,
                             containerView: containerView) {
            transitionContext.completeTransition(true)
         }
      }
   }
   
   private func animateToDetailVC(mainView: UIView, detailView: UIView, containerView: UIView, completion: @escaping (() -> Void)) {
      detailView.layer.cornerRadius = detailView.bounds.height/2
      detailView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
      detailView.frame = buttonFrame
      containerView.addSubview(detailView)
      
      UIView.animate(
         withDuration: duration,
         delay: 0.0,
         usingSpringWithDamping: 0.5,
         initialSpringVelocity: 0.0,
         animations: {
            // animations
            detailView.transform = .identity
            detailView.frame = containerView.frame
            detailView.layer.cornerRadius = 0
      },
         completion: { _ in
            completion()
            mainView.alpha = 1.0
      })
   }
   
   private func animateBackToMainVC(mainView: UIView, detailView: UIView, containerView: UIView, completion: @escaping (() -> Void)) {
      containerView.addSubview(mainView)
      containerView.bringSubview(toFront: detailView)
      
      UIView.animate(withDuration: duration/2,
                     delay: 0.0,
                     options: [],
                     animations: {
                        detailView.center = CGPoint(x: self.buttonFrame.midX, y: self.buttonFrame.midY)
                        
                        let scaleX = 0.1 * (self.buttonFrame.width / detailView.frame.width)
                        let scaleY = 0.1 * (self.buttonFrame.height / detailView.frame.height)
                        
                        print("scale x and y:")
                        print(scaleX)
                        print(scaleY)
                        detailView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                        
                        detailView.layer.cornerRadius = detailView.bounds.width/2
      },
                     completion: { (_) in
                        completion()
      })
   }
   
}
