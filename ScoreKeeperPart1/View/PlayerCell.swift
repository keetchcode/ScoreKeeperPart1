//
//  PlayerCellTableViewCell.swift
//  ScoreKeeperPart1
//
//  Created by Wesley Keetch on 11/18/24.
//

import UIKit

class PlayerCell: UITableViewCell {

  @IBOutlet weak var playerImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var stepper: UIStepper!

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
