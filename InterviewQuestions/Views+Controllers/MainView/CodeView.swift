//
//  CodeView.swift
//  InterviewQuestions
//
//  Created by Joe Lucero on 5/9/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import UIKit

@IBDesignable
class CodeView: UIView {

   @IBInspectable let customBackgroundColor: UIColor = UIColor.black
   @IBInspectable let customCodeColor: UIColor = UIColor.white
   private let cornerRadius: CGFloat = 10.0
   private let spacingConstant: CGFloat = 20.0
   private let codeTextLabel = UILabel()

   var codeText: String = "" {
      didSet {
         configure()
         // FIXME: - Do I need this??
         layoutIfNeeded()
      }
   }
   
   init(){
      super.init(frame: .zero)
      setUp()
   }

   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   
   override func awakeFromNib() {
      super.awakeFromNib()
      setUp()
      layoutIfNeeded()
   }
   
   override func prepareForInterfaceBuilder() {
      super.prepareForInterfaceBuilder()
      setUp()
      layoutSubviews()
   }
   
   // Setup Function (once)
   private func setUp() {
      backgroundColor = customBackgroundColor
      addSubview(codeTextLabel)
      
      self.layer.cornerRadius = cornerRadius
      self.clipsToBounds = true
      
      // FIXME: - Can I move this one line down into layout subviews (keep constraints together)
      codeTextLabel.backgroundColor = customBackgroundColor
      codeTextLabel.textColor = customCodeColor
      codeTextLabel.numberOfLines = 0
      codeTextLabel.lineBreakMode = .byWordWrapping
      codeTextLabel.adjustsFontSizeToFitWidth = true
      codeTextLabel.minimumScaleFactor = 0.1
      codeTextLabel.text = "test\n\nquestion"
      
      codeTextLabel.translatesAutoresizingMaskIntoConstraints = false
      codeTextLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: spacingConstant).isActive = true
      codeTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: spacingConstant).isActive = true
      codeTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -spacingConstant).isActive = true
      codeTextLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -spacingConstant).isActive = true
   }
   
   // Configure (every time codeText gets updated)
   private func configure() {
      codeTextLabel.text = codeText
   }
   
}
