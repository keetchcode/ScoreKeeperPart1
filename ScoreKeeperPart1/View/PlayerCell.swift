//
//  PlayerCellTableViewCell.swift
//  ScoreKeeperPart1
//
//  Created by Wesley Keetch on 11/18/24.
//

import UIKit

class PlayerCell: UITableViewCell {
  
  @IBOutlet weak var playerImageView: UIImageView!
  @IBOutlet weak var playerNameLabel: UILabel!
  @IBOutlet weak var playerScoreLabel: UILabel!
  @IBOutlet weak var stepper: UIStepper!
  
  func updateLabels(with player: Player) {
    playerNameLabel.text = player.name
    playerScoreLabel.text = "\(player.score)"
    playerImageView.image = UIImage(named: player.image) ?? UIImage(systemName: "person.fill")
  }
}

