//
//  MenuButton.swift
//  Memor
//
//  Created by Valeryia Beizer on 7/28/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import UIKit

@IBDesignable open class StartButton: UIButton {
  
  override open func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    self.custom()
  }
  
  override open func awakeFromNib() {
    super.awakeFromNib()
    self.custom()
  }
  
  private func custom(){
    layer.cornerRadius = 5.0
  }
}
