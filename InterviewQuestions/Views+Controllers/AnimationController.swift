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
   var isPresenting = true
   var buttonFrame: CGRect!
   var buttonImage: UIImage!
   var backgroundLayer: CAGradientLayer!
   
   func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
      return duration
   }
   
   func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
      let containerView = transitionContext.containerView
      let toView = transitionContext.view(forKey: .to)!
      let fromView = transitionContext.view(forKey: .from)!
      
      let mainView = isPresenting ? fromView : toView
      let detailView = isPresenting ? toView : fromView
      
      detailView.layer.borderWidth = 3.0
      detailView.layer.borderColor = UIColor.black.cgColor
      
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
      
//      let scaleX = buttonFrame.width / detailView.frame.width
      let scaleY = buttonFrame.height / detailView.frame.height
      
      detailView.layer.cornerRadius = detailView.bounds.width/2
      detailView.transform = CGAffineTransform(scaleX: scaleY, y: scaleY)
      detailView.frame = buttonFrame
      containerView.addSubview(detailView)
      containerView.layoutIfNeeded()
      
      let buttonImageView = UIImageView(image: buttonImage)
      buttonImageView.frame = CGRect(x: 0, y: 0, width: mainView.frame.width, height: mainView.frame.height)
      buttonImageView.alpha = 0.7
      detailView.addSubview(buttonImageView)
      
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
            buttonImageView.frame = CGRect(x: 0, y: containerView.frame.width/2, width: containerView.frame.width, height: containerView.frame.width)
            buttonImageView.alpha = 0
      },
         completion: { _ in
            completion()
            mainView.alpha = 1.0
            buttonImageView.removeFromSuperview()
      })
   }
   
   private func animateBackToMainVC(mainView: UIView, detailView: UIView, containerView: UIView, completion: @escaping (() -> Void)) {
      containerView.addSubview(mainView)
      containerView.bringSubview(toFront: detailView)
      
      let buttonImageView = UIImageView(image: buttonImage)
      buttonImageView.frame = CGRect(x: 0, y: detailView.frame.width/2, width: detailView.frame.width, height: detailView.frame.width)
      buttonImageView.alpha = 0
      detailView.addSubview(buttonImageView)
      
      UIView.animate(withDuration: duration/2,
                     delay: 0.0,
                     options: [],
                     animations: {
                        detailView.layer.cornerRadius = mainView.frame.width/2
                        detailView.center = CGPoint(x: self.buttonFrame.midX, y: self.buttonFrame.midY)

                        let scaleX = (self.buttonFrame.width / detailView.frame.width)
                        let scaleY = (self.buttonFrame.height / detailView.frame.height)

                        detailView.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)

                        buttonImageView.frame = CGRect(x: 0, y: 0, width: detailView.bounds.width, height: detailView.bounds.height)

                        detailView.viewWithTag(500)?.alpha = 0
                        buttonImageView.alpha = 1.0
                        
      },
                     completion: { (_) in
                        buttonImageView.removeFromSuperview()
                        completion()
      })
   }
   
}
