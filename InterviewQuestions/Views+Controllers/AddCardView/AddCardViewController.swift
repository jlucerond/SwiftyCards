//
//  AddCardViewController.swift
//  InterviewQuestions
//
//  Created by Joe Lucero on 5/12/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController {
   
   @IBOutlet weak var backButton: UIButton!
   var backgroundGradientLayer: CAGradientLayer!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      backButton.layer.cornerRadius = 10.0
      
      view.layer.masksToBounds = true
      view.layer.addSublayer(backgroundGradientLayer)
      
      backgroundGradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
      backgroundGradientLayer.masksToBounds = true
      backgroundGradientLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
      backgroundGradientLayer.zPosition = -1
   }
   
   @IBAction func backButtonPressed(_ sender: UIButton) {
      dismiss(animated: true, completion: nil)
   }
   
   
}
