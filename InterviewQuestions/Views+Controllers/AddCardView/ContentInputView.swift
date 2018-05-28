//
//  ContentInputView.swift
//  InterviewQuestions
//
//  Created by Joe Lucero on 5/25/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import UIKit

@IBDesignable
class ContentInputView: UIView {

   @IBInspectable var topic: String = "topic" {
      didSet {
         setUp()
      }
   }
   
   @IBInspectable var value: String = "value" {
      didSet {
         setUp()
      }
   }
   @IBInspectable var margin: CGFloat = 5 {
      didSet {
         setUp()
      }
   }
   
   private let title = UILabel()
   private let textField = UITextField()
   
   override func prepareForInterfaceBuilder() {
      super.prepareForInterfaceBuilder()
      setUp()
      layoutSubviews()
   }

   func setUp() {
      title.text = topic
      addSubview(title)
      
//      textField.text = value
//      addSubview(textField)
      
      addConstraints()
   }

   func addConstraints() {
      title.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
      title.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
      
//      textField.topAnchor.constraint(equalTo: title.bottomAnchor, constant: margin).isActive = true
//      textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
   }
   
}
