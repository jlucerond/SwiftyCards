//
//  StatView.swift
//  InterviewQuestions
//
//  Created by Joe Lucero on 5/17/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import UIKit

@IBDesignable
class StatView: UIView {
   
   let percentLabel = UILabel()
   let captionLabel = UILabel()
   
   var range: CGFloat = 10
   var curValue: CGFloat = 5
   let margin: CGFloat = 10
   
   let bgLayer = CAShapeLayer()
   @IBInspectable var bgColor: UIColor = UIColor.gray
   
   let fgLayer = CAShapeLayer()
   @IBInspectable var fgColor: UIColor = UIColor.black
   
   override func awakeFromNib() {
      super.awakeFromNib()
      
      // Calculate Score
      range = CGFloat(CardModelController.shared.usersTopPossibleScore)
      curValue = CGFloat(CardModelController.shared.usersCurrentScore)
      
      setup()
   }
   
   override func prepareForInterfaceBuilder() {
      super.prepareForInterfaceBuilder()
      
      setup()
   }
   
   func setup() {
      // Setup background layer
      bgLayer.strokeColor = bgColor.cgColor
      bgLayer.fillColor = nil
      bgLayer.lineWidth = 40.0
      bgLayer.strokeEnd = 1.0
      layer.addSublayer(bgLayer)
      
      // Setup foreground layer
      fgLayer.strokeColor = fgColor.cgColor
      fgLayer.fillColor = nil
      fgLayer.lineWidth = 40.0
      fgLayer.strokeEnd = 0
      layer.addSublayer(fgLayer)
      
      // Setup percent label
      percentLabel.font = UIFont.systemFont(ofSize: 50)
      percentLabel.textColor = UIColor.black
      percentLabel.text = "0/0"
      addSubview(percentLabel)
      
      // Setup caption label
      captionLabel.font = UIFont(name: "Marker Felt", size: 40.0)
      captionLabel.adjustsFontSizeToFitWidth = true
      captionLabel.minimumScaleFactor = 0.1
      captionLabel.text = "Percent Complete"
      captionLabel.textColor = UIColor.black
      addSubview(captionLabel)
      
      // Setup constraints
      percentLabel.translatesAutoresizingMaskIntoConstraints = false
      let percentLabelCenterX = percentLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
      let percentLabelCenterY = percentLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
      NSLayoutConstraint.activate([percentLabelCenterX, percentLabelCenterY])
      
      captionLabel.translatesAutoresizingMaskIntoConstraints = false
      let captionLabelCenterX = captionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
      let captionLabelBottom = captionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -margin)
      NSLayoutConstraint.activate([captionLabelCenterX, captionLabelBottom])
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      setUp(shapeLayer: bgLayer)
      setUp(shapeLayer: fgLayer)
      showPercentComplete()
   }
   
   private func setUp(shapeLayer: CAShapeLayer) {
      shapeLayer.frame = self.bounds
      let startAngle = CGFloat(135).convertFromDegreesToRadians
      let endAngle = CGFloat(45).convertFromDegreesToRadians
      let center = percentLabel.center
      let radius = self.bounds.width * 0.35
      let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
      shapeLayer.path = path.cgPath
   }
   
   private func showPercentComplete() {
      let percentComplete = curValue/range
      fgLayer.strokeEnd = percentComplete
      percentLabel.text = String(format: "%d%%", Int(100 * percentComplete))
   }

}

extension CGFloat {
   var convertFromDegreesToRadians: CGFloat {
      return self * CGFloat(Double.pi) / 180.0
   }
   
   var convertFromRadiansToDegrees: CGFloat {
      return self * 180.0 / CGFloat(Double.pi)
   }
}
