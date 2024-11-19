//
//  Player.swift
//  ScoreKeeperPart1
//
//  Created by Wesley Keetch on 11/18/24.
//

import Foundation
import UIKit

struct Player: Codable, Identifiable {
  var id = UUID()
  var name: String
  var score: Int
  var image: String
  
  var description: String
}
