//
//  PlayerListViewController.swift
//  ScoreKeeperPart1
//
//  Created by Wesley Keetch on 11/18/24.
//

import UIKit

class PlayerListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddPlayerDelegate {

  @IBOutlet weak var playerListTableView: UITableView!

  var players: [Player] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    playerListTableView.dataSource = self
    playerListTableView.delegate = self

    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlayerTapped))
    navigationItem.rightBarButtonItem = addButton

    players = [
      Player(name: "Mike", score: 100, image: "mike", description: ""),
      Player(name: "Ryan", score: 80, image: "ryan", description: ""),
      Player(name: "Nathan", score: 60, image: "nathan", description: ""),
      Player(name: "Parker", score: 40, image: "parker", description: "")
    ]

    loadPlayers()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    savePlayers()
  }

  // MARK: - Add Player

  @objc func addPlayerTapped(_ sender: Any) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    if let addPlayerVC = storyboard.instantiateViewController(withIdentifier: "AddPlayerViewController") as? AddPlayerViewController {
      addPlayerVC.delegate = self
      navigationController?.pushViewController(addPlayerVC, animated: true)
    }
  }

  func didAddPlayer(_ player: Player) {
    players.append(player)
    sortPlayers()
    playerListTableView.reloadData()
    savePlayers()
  }

  // MARK: - Table View Data Source

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return players.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerCell else {
      return UITableViewCell()
    }

    let player = players[indexPath.row]

    cell.updateLabels(with: player)
    cell.stepper.value = Double(player.score)
    cell.stepper.tag = indexPath.row
    cell.stepper.addTarget(self, action: #selector(scoreChanged(_:)), for: .valueChanged)

    return cell
  }


  // MARK: - Score Update with Stepper

  @objc func scoreChanged(_ sender: UIStepper) {
    let index = sender.tag
    players[index].score = Int(sender.value)
    sortPlayers()
    playerListTableView.reloadData()
  }

  // MARK: - Player Sorting

  func sortPlayers() {
    players.sort { $0.score > $1.score }
  }

  // MARK: - Data Persistence

  func savePlayers() {
    do {
      let encodedData = try JSONEncoder().encode(players)
      UserDefaults.standard.set(encodedData, forKey: "players")
    } catch {
      print("Error encoding players: \(error)")
    }
  }

  func loadPlayers() {
    if let savedData = UserDefaults.standard.data(forKey: "players") {
      do {
        players = try JSONDecoder().decode([Player].self, from: savedData)
      } catch {
        print("Error decoding players: \(error)")
      }
    }
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowPlayerDetailsSegue" {
      if let indexPath = playerListTableView.indexPathForSelectedRow,
         let destinationVC = segue.destination as? PlayerDetailsViewController {
        destinationVC.player = players[indexPath.row]
      }
    }
  }

}
