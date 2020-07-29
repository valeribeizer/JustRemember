//
//  GameCollectionView.swift
//  Memor
//
//  Created by Valeryia Beizer on 7/28/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import UIKit

class GameCollectionView: UICollectionView {
  //  MARK: - Variables
  let spacing = CGFloat(1.0)
  
  //  MARK: - Methods
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func set(size: Int) {
    let width = Int(frame.size.width - spacing * CGFloat(size)) - 1
    let height = Int(frame.size.height - spacing * CGFloat(size))
    
    let cellSize = CGSize(width: (width) / size, height: (height) / size)
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.itemSize = cellSize
    layout.sectionInset = UIEdgeInsets(top: spacing,
                                       left: spacing,
                                       bottom: spacing,
                                       right: spacing)
    layout.minimumLineSpacing = 1.0
    layout.minimumInteritemSpacing = 0.0
    self.setCollectionViewLayout(layout, animated: true)
    self.reloadData()
  }
}
