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

   @IBInspectable var topic: String = ""
   @IBInspectable var value: String = ""
   @IBInspectable var margin: CGFloat = 5
   @IBInspectable var textViewColor: UIColor = UIColor.white
   @IBInspectable var textViewTextColor: UIColor = UIColor.black
   
   private let titleLabel = UILabel()
   private let textView = UITextView()
   
   var userInput: String? {
      return textView.text
   }
   
   override func prepareForInterfaceBuilder() {
      super.prepareForInterfaceBuilder()
      invalidateIntrinsicContentSize()
      setUp()
   }
   
   override func awakeFromNib() {
      super.awakeFromNib()
      invalidateIntrinsicContentSize()
      setUp()
   }

   func setUp() {
      titleLabel.text = topic
      textView.text = value
      addSubview(titleLabel)
      
      textView.backgroundColor = textViewColor
      textView.textColor = textViewTextColor
      textView.layer.borderColor = (textViewColor == UIColor.black) ? UIColor.white.cgColor : UIColor.black.cgColor
      textView.layer.borderWidth = 2.0
      textView.isScrollEnabled = false
      textView.addClearAndDoneButtons()
      addSubview(textView)
      
      addConstraints()
   }
   
//   @objc func something() {
//      textField.heightAnchor.constraint(equalToConstant: 100).isActive = true
//      textField.inpu
//   }

   func addConstraints() {
      titleLabel.translatesAutoresizingMaskIntoConstraints = false
      titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
      titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
      
      textView.translatesAutoresizingMaskIntoConstraints = false
      textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: margin).isActive = true
      textView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
      textView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -margin).isActive = true
      
      let textViewBottomConstraint = textView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
      textViewBottomConstraint.priority = UILayoutPriority(rawValue: 300)
      textViewBottomConstraint.isActive = true
      
//      textField.readableContentGuide
      
//      let height = title.frame.height + textView.frame.height + margin
//      self.heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
   }
   
   override var intrinsicContentSize: CGSize {
      let intrinsicHeight = titleLabel.intrinsicContentSize.height + margin + textView.intrinsicContentSize.height
      print(intrinsicHeight)
      return CGSize(width: 100, height: intrinsicHeight)
   }
   

   
}

extension UITextView {
   
   func addClearAndDoneButtons() {
      let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
      doneToolbar.barStyle = .default
      
      let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
      let clear: UIBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(self.clearButtonAction))
      
      let items = [clear, flexSpace, done]
      doneToolbar.items = items
      doneToolbar.sizeToFit()
      
      self.inputAccessoryView = doneToolbar
   }
   
   @objc func doneButtonAction() {
      self.resignFirstResponder()
   }
   
   @objc func clearButtonAction() {
      self.text = ""
   }

}

