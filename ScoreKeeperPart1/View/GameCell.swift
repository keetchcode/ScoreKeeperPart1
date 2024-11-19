//
//  GameCell.swift
//  ScoreKeeperPart1
//
//  Created by Wesley Keetch on 11/19/24.
//

import UIKit

class GameCell: UITableViewCell {






  func updateLabels(with player: Player) {
    nameLabel.text = player.name
    scoreLabel.text = String(player.score)
    playerImageView.image = UIImage(named: player.image)!
    }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
