//
//  GameModel.swift
//  Memor
//
//  Created by Valeryia Beizer on 7/28/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import Foundation

// MARK: - Protocols
protocol GameDelegate {
  func game(contents: [Bool])
  func game(situation: GameSituation)
  func game(time: Double)
  func game(score: Int, level: Int, lives: Int)
  func gameDead(shown: Bool)
}

// MARK: - Enum
enum GameSituation {
  case show, hide, final
}

class Game {
  //  MARK: - Variables
  static var shared = Game()
  var delegate: GameDelegate?
  let resolution = 0.01
  let finalShowTime = 1.5
  
  var score = 0 {
    didSet {
      self.delegate?.game(score: score, level: level.val, lives: lives)
    }
  }
  var lives = 5 {
    didSet {
      self.delegate?.game(score: score, level: level.val, lives: lives)
    }
  }
  var level: Level = Level(val: 1) {
    didSet {
      self.delegate?.game(score: score, level: level.val, lives: lives)
    }
  }
  var contents: [Bool] = []
  var toucheds: [Int] = []
  var timeLeft = 0.0
  var timer: Timer?
  
  var situation: GameSituation = .show {
    didSet {
      self.delegate?.game(situation: situation)
    }
  }
  
  //    MARK: - Initialization
  init() {}
  
  //  MARK: - Actions
  @objc func updateTimer() {
    if self.timeLeft > 0.0 {
      self.timeLeft -= self.resolution
      self.delegate?.game(time: self.timeLeft)
    } else {
      self.lives -= 1
      if self.checkDead() {
        self.endGame()
      } else {
        self.finishLevel()
      }
    }
  }
  
  //  MARK: - Methods
  func initLevel() {
    self.contents = (0..<self.level.size * self.level.size).map({ _ in false })
    for _ in 0..<self.level.askCount {
      var rand = (0..<self.contents.count).randomElement()!
      while self.contents[rand] {
        rand = (0..<self.contents.count).randomElement()!
      }
      self.contents[rand] = true
    }
    self.delegate?.game(contents: self.contents)
    
    self.toucheds = []
    self.situation = .show
    self.timeLeft = level.seconds
    self.delegate?.game(score: self.score, level: self.level.val, lives: self.lives)
    let _ = setTimeout(delay: self.level.showSeconds) {
      self.startLevel()
    }
  }
  
  func startLevel() {
    self.situation = .hide
    self.timer = Timer.scheduledTimer(timeInterval: self.resolution,
                                      target: self,
                                      selector: #selector(updateTimer),
                                      userInfo: nil,
                                      repeats: true)
    self.delegate?.game(time: self.timeLeft)
  }
  
  func finishLevel() {
    self.situation = .final
    self.timer?.invalidate()
    let _ = setTimeout(delay: self.finalShowTime) {
      self.level = self.level.next()
      self.initLevel()
    }
  }
  
  func click(on: Int) -> Bool {
    if self.situation == .hide && !self.toucheds.contains(on){
      self.toucheds.append(on)
      let success = self.contents[on]
      if success {
        self.score += 5
        if checkFinished() {
          self.finishLevel()
        }
      } else {
        self.lives -= 1
        if self.checkDead() {
          self.endGame()
        }
      }
      return success
    }
    return false
  }
  
  func checkFinished() -> Bool {
    for (i, c) in self.contents.enumerated() {
      if c && !self.toucheds.contains(i) {
        return false
      }
    }
    return true
  }
  
  func checkDead() -> Bool {
    if self.lives < 0 {
      return true
    }
    return false
  }
  
  func endGame() {
    self.finishLevel()
    self.delegate?.gameDead(shown: false)
    let _ = setTimeout(delay: self.finalShowTime) {
      self.delegate?.gameDead(shown: true)
    }
  }
}



