//
//  Game.swift
//  ScoreKeeperPart1
//
//  Created by Wesley Keetch on 11/19/24.
//

import Foundation

struct Game: Codable {
  var gameType: String
  var score: Int
  var image: String
  var description: String
  var players: [Player]
}

