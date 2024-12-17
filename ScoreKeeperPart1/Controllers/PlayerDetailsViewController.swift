//
//  PlayerDetailsViewController.swift
//  ScoreKeeperPart1
//
//  Created by Wesley Keetch on 12/12/24.
//

import UIKit

class PlayerDetailsViewController: UIViewController {

  @IBOutlet weak var playerScoreLabel: UILabel!
  @IBOutlet weak var playerNameLabel: UILabel!
  @IBOutlet weak var playerImageView: UIImageView!

  var player: Player?

  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }

  private func configureView() {
    guard let player = player else { return }
    playerNameLabel.text = player.name
    playerScoreLabel.text = "Score: \(player.score)"
    playerImageView.image = UIImage(named: player.image)
  }
}

