//
//  GameViewController.swift
//  Memor
//
//  Created by Valeryia Beizer on 7/28/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, GameDelegate {
  //  MARK: - Variables
  let identifier = "MainViewController"
  
  // MARK: - GUI Variables
  @IBOutlet weak var livesStack: UIStackView!
  @IBOutlet weak var gameCollectionView: GameCollectionView!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
  @IBOutlet weak var timeSlider: GameTimerSlider!
  @IBOutlet weak var timeParent: UIView!
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.gameCollectionView.delegate = self
    Game.shared.delegate = self
    
    self.timeParent.layer.cornerRadius = 10
    self.gameCollectionView.layer.cornerRadius = 3
    
    self.gameCollectionView.set(size: Game.shared.level.size)
    Game.shared.initLevel()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    self.navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  //  MARK: - Methods
  func game(contents: [Bool]) {
    self.gameCollectionView.reloadData()
  }
  
  func game(situation: GameSituation) {
    self.gameCollectionView.reloadData()
    switch situation {
    case .show:
      self.timeSlider.maximumValue = Float(Game.shared.level.seconds)
      self.timeSlider.minimumValue = 0.0
      self.timeSlider.value = Float(Game.shared.level.seconds)
      self.gameCollectionView.set(size: Game.shared.level.size)
      break
    case .hide:
      break
    case .final:
      break
    }
  }
  
  func game(time: Double) {
    self.timeSlider.value = Float(time)
  }
  
  func game(score: Int, level: Int, lives: Int) {
    self.roundLabel.text = String(level)
    self.scoreLabel.text = String(score)
    let _ = self.livesStack.subviews.map({ v in v.removeFromSuperview() })
    
    let width = self.livesStack.frame.width
    let liveWidth = ((width - 5) / 5)
    if lives >= 0 {
      for i in 0..<lives {
        let heartImage = UIImageView(image: UIImage(named: "heart")!)
        heartImage.frame = CGRect(x: CGFloat(i) * liveWidth + 5, y: 0, width: liveWidth, height: 50)
        heartImage.contentMode = .scaleAspectFit
        self.livesStack.addSubview(heartImage)
      }
    }
    self.livesStack.layoutSubviews()
  }
  
  func gameDead(shown: Bool) {
    if shown {
      Game.shared = Game()
      self.dismiss(animated: true, completion: nil)
    } else {
      self.toast(message: "Game Over!")
    }
  }
  
  //  MARK: - UICollectionViewDelegate, UICollectionViewDataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return Game.shared.contents.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as! GameCollectionViewCell
    switch Game.shared.situation {
    case .show:
      if Game.shared.contents[indexPath.row] {
        cell.type = .show
      } else {
        cell.type = .hidden
      }
      break
    case .hide:
      if Game.shared.toucheds.contains(indexPath.row) {
        if Game.shared.contents[indexPath.row] {
          cell.type = .success
        } else {
          cell.type = .error
        }
      } else {
        cell.type = .hidden
      }
      break
    case .final:
      if Game.shared.toucheds.contains(indexPath.row) {
        if Game.shared.contents[indexPath.row] {
          cell.type = .success
        } else {
          cell.type = .error
        }
      } else {
        if Game.shared.contents[indexPath.row] {
          cell.type = .show
        } else {
          cell.type = .hidden
        }
      }
      break
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if Game.shared.situation == .hide {
      let _ = Game.shared.click(on: indexPath.row)
      self.gameCollectionView.reloadData()
    }
  }
}

