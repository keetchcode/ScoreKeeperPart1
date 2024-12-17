//
//  ScoreKeeperViewController.swift
//  ScoreKeeperPart1
//
//  Created by Wesley Keetch on 11/20/24.
//

import UIKit

class ScoreKeeperViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var playersTableView: UITableView!
  @IBOutlet weak var gameTypeLabel: UILabel!
  @IBOutlet weak var gameImageView: UIImageView!
  @IBOutlet weak var winnerLabel: UILabel!

  var game: Game!
  var players: [Player] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    guard let game = game else {
      print("Error: Game object is nil")
      navigationController?.popViewController(animated: true)
      return
    }

    gameTypeLabel.text = game.gameType
    gameImageView.image = UIImage(named: game.image) ?? UIImage(systemName: "gamecontroller.fill")
    players = game.players
    sortPlayers()
    updateWinner()

    playersTableView.dataSource = self
    playersTableView.delegate = self
  }

  // MARK: - Table View Data Source

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return players.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerCell else {
      fatalError("Error: Could not dequeue a cell with identifier 'PlayerCell'")
    }

    let player = players[indexPath.row]

    cell.updateLabels(with: player)
    cell.stepper.value = Double(player.score)
    cell.stepper.minimumValue = 0
    cell.stepper.tag = indexPath.row
    cell.stepper.addTarget(self, action: #selector(scoreChanged(_:)), for: .valueChanged)

    return cell
  }

  // MARK: - Stepper Action

  @objc func scoreChanged(_ sender: UIStepper) {
    let index = sender.tag
    players[index].score = Int(sender.value)

    sortPlayers()
    updateWinner()
    playersTableView.reloadData()
  }

  // MARK: - Helper Methods

  private func sortPlayers() {
    if game.description.lowercased() == "highest score" {
      players.sort { $0.score > $1.score }
    } else if game.description.lowercased() == "lowest score" {
      players.sort { $0.score < $1.score }
    }
  }

  private func updateWinner() {
    guard let winner = players.first else {
      winnerLabel.text = "No players in the game."
      return
    }
    winnerLabel.text = "Winner: \(winner.name) (\(winner.score) points)"
  }
}
