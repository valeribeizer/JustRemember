//
//  GameCollectionViewCell.swift
//  Memor
//
//  Created by Valeryia Beizer on 7/28/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import UIKit

//  MARK: - Enum
enum GameCellType {
  case hidden, show, success, error
}

class GameCollectionViewCell: UICollectionViewCell {
  //  MARK: - Variables
  var colors: [GameCellType:UIColor] = [
    .hidden : #colorLiteral(red: 0.6632847786, green: 0.7693134546, blue: 1, alpha: 1),
    .show : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),
    .success : #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),
    .error: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
  ]
  var type: GameCellType = .hidden {
    didSet {
      contentView.backgroundColor = colors[type]
      contentView.layoutIfNeeded()
    }
  }
  
  //  MARK: - Methods
  override func awakeFromNib() {
    super.awakeFromNib()
    contentView.backgroundColor = colors[type]
  }
}
