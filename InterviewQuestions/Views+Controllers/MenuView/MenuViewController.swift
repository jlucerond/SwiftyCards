//
//  MenuViewController.swift
//  InterviewQuestions
//
//  Created by Joe Lucero on 5/12/18.
//  Copyright © 2018 Joe Lucero. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
   
   var backgroundGradientLayer: CAGradientLayer!
   @IBOutlet weak var collectionView: UICollectionView!
   @IBOutlet weak var backButton: UIButton!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      view.layer.masksToBounds = true
      backgroundGradientLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
      backgroundGradientLayer.masksToBounds = true
      backgroundGradientLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
      backgroundGradientLayer.zPosition = -1
      view.layer.addSublayer(backgroundGradientLayer)
      
      backButton.layer.cornerRadius = 10.0

   }
   
   override func viewWillAppear(_ animated: Bool) {
      collectionView.layoutIfNeeded()
      
      let cellWidth = collectionView.bounds.size.width * 0.75
      let cellHeight = collectionView.bounds.size.height * 0.75
      
      let collectionLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
      collectionLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
   }
   
   
   @IBAction func backButtonPressed(_ sender: UIButton) {
      dismiss(animated: true, completion: nil)
   }
   
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 7
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      let cardPack: CardModelController.CardPack
      switch indexPath.row {
      case 0: cardPack = .programmingTheory
      case 1: cardPack = .beginnerSwift
      case 2: cardPack = .beginnerSwift2
      case 3: cardPack = .intermediateSwift
      case 4: cardPack = .intermediateSwift2
      case 5: cardPack = .advancedSwift
      case 6: cardPack = .advancedSwift2
      default: cardPack = .noCardPackFound
      }
      
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionPackCell", for: indexPath) as! QuestionPackCollectionViewCell
      cell.questionPack = cardPack
      return cell
   }
   
   
}
