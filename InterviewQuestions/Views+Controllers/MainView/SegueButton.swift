//
//  SegueButton.swift
//  InterviewQuestions
//
//  Created by Joe Lucero on 5/12/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import UIKit

@IBDesignable
class SegueButton: UIButton {

   @IBInspectable var startColor: UIColor = UIColor.green
   @IBInspectable var endColor: UIColor = UIColor.blue
   
   let backgroundGradientLayer = CAGradientLayer()
   
   // LifeCycle Methods
   override func awakeFromNib() {
      super.awakeFromNib()
      setUp()
   }
   
   override func prepareForInterfaceBuilder() {
      super.prepareForInterfaceBuilder()
      setUp()
   }
   
   private func setUp() {
      layer.cornerRadius = bounds.height > bounds.width ? bounds.height/2 : bounds.width/2
      
      layer.borderColor = UIColor.black.cgColor
      layer.borderWidth = 3.0
      layer.masksToBounds = true
      
      backgroundGradientLayer.frame = self.bounds
      backgroundGradientLayer.colors = [startColor.cgColor, endColor.cgColor]
      backgroundGradientLayer.startPoint = CGPoint(x: 0.5, y: 0.25)
      backgroundGradientLayer.endPoint = CGPoint(x: 0.5, y: 0.75)

      layer.addSublayer(backgroundGradientLayer)
      if let imageView = imageView {
         bringSubview(toFront: imageView)
      }
   }

}
