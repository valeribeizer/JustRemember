//
//  LevelModel.swift
//  Memor
//
//  Created by Valeryia Beizer on 7/28/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import Foundation

struct Level {
  //  MARK: - Variables
  var val: Int
  var size: Int {
    return self.val / 4 + 2
  }
  var askCount: Int {
    return self.size + (val % 4) - 1
  }
  var seconds: Double {
    return Double(self.size)
  }
  var showSeconds: Double {
    return Double(self.size) / 3.0
  }
  
  //  MARK: - Initialization
  init(val: Int) {
    self.val = val
  }
  
  //  MARK: - Methods
  func next() -> Level {
    return Level.init(val: self.val + 1)
  }
}

