//
//  JustRememberTests.swift
//  JustRememberTests
//
//  Created by Valeryia Beizer on 7/28/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import XCTest
@testable import JustRemember

class JustRememberTests: XCTestCase {
  func testLevels() {
    var level = Level(val: 4)
    XCTAssertEqual(level.size, 3)
    XCTAssertEqual(level.askCount, 2)
    XCTAssertEqual(level.seconds, 3.0)
    
    level = Level(val: 100)
    XCTAssertEqual(level.size, 27)
    XCTAssertEqual(level.askCount, 26)
    XCTAssertEqual(level.seconds, 27.0)
    
  }
}
