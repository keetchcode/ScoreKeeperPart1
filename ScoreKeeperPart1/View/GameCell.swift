//
//  GameCell.swift
//  ScoreKeeperPart1
//
//  Created by Wesley Keetch on 11/19/24.
//

import UIKit

class GameCell: UITableViewCell {
  
  @IBOutlet weak var gameImageView: UIImageView!
  @IBOutlet weak var gameLabel: UILabel!
  @IBOutlet weak var winnerLabel: UILabel!
  @IBOutlet weak var winnerScoreLabel: UILabel!
  
  func updateLabels(with game: Game) {
    gameImageView.image = UIImage(named: game.image)!
    gameLabel.text = game.gameType
    winnerLabel.text = game.description
    winnerScoreLabel.text = String(game.score)
  }
}
