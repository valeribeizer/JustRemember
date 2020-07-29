//
//  GameTimerSlider.swift
//  Memor
//
//  Created by Valeryia Beizer on 7/28/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import UIKit

class GameTimerSlider: UISlider {
  //  MARK: - Variables
  @IBInspectable open var trackWidth: CGFloat = 2 {
    didSet {
      setNeedsDisplay()
    }
  }
  
  //    MARK: - Methods
  override open func trackRect(forBounds bounds: CGRect) -> CGRect {
    let defaultBounds = super.trackRect(forBounds: bounds)
    return CGRect(x: defaultBounds.origin.x,
                  y: defaultBounds.origin.y + defaultBounds.size.height/2 - trackWidth/2,
                  width: defaultBounds.size.width,
                  height: trackWidth)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.custom()
  }
  
  private func custom() {
    let leftColor = #colorLiteral(red: 0.5593310966, green: 0.5578248868, blue: 0.8549019694, alpha: 1)
    let rightColor = #colorLiteral(red: 0.7843137255, green: 0.8392156863, blue: 0.8980392157, alpha: 1)
    
    minimumTrackTintColor = leftColor
    maximumTrackTintColor = rightColor
  }
}
