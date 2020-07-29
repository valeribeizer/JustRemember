//
//  Utilities.swift
//  Memor
//
//  Created by Valeryia Beizer on 7/28/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import Foundation
import Darwin

func setTimeout(delay: TimeInterval, block: @escaping () ->Void) -> Timer {
  return Timer.scheduledTimer(timeInterval: delay,
                              target: BlockOperation(block: block),
                              selector: #selector(Operation.main),
                              userInfo: nil,
                              repeats: false)
}

infix operator **

func ** (num: Double, power: Double) -> Double {
  return pow(num, power)
}

