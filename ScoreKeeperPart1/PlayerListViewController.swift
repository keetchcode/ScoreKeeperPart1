//
//  PlayerListViewController.swift
//  ScoreKeeperPart1
//
//  Created by Wesley Keetch on 11/18/24.
//

import UIKit

class PlayerListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddPlayerViewController.AddPlayerDelegate {

  @IBOutlet weak var tableView: UITableView!

  protocol AddPlayerDelegate: AnyObject {
    func didAddPlayer(_ player: Player)
  }

  var players: [Player] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate
    = self

    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlayerTapped))

    navigationItem.rightBarButtonItem = addButton

    players = [
      Player(name: "Mike", score: 100, image: "mike", description: ""),
      Player(name: "Ryan", score: 80,  image: "ryan", description: ""),
      Player(name: "Nathan", score: 60, image: "nathan", description: ""),
      Player(name: "Parker", score: 40, image: "parker", description: "")
    ]

    tableView.reloadData()

    loadPlayers()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    savePlayers()
  }

  @IBAction func addPlayerTapped(_ sender: Any) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    if let addPlayerVC = storyboard.instantiateViewController(withIdentifier: "AddPlayerViewController") as? AddPlayerViewController {
      addPlayerVC.delegate = self
      navigationController?.pushViewController(addPlayerVC, animated: true)
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return players.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerCell else {
      return UITableViewCell()
    }

    let player = players[indexPath.row]
//    cell.nameLabel.text = player.name
//    cell.scoreLabel.text = "\(player.score)

    cell.updateLabels(with: player)

    cell.stepper.value = Double(player.score)

    cell.stepper.tag = indexPath.row
    cell.stepper.addTarget(self, action: #selector(scoreChanged(_:)), for: .valueChanged)

    return cell
  }

  @objc func scoreChanged(_ sender: UIStepper) {
    let index = sender.tag
    players[index].score = Int(sender.value)
    sortPlayers()

    tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
  }

  func didAddPlayer(_ player: Player) {
    players.append(player)
    sortPlayers()
    tableView.reloadData()
    savePlayers()
  }

  func sortPlayers() {
    players.sort { $0.score > $1.score }
  }

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
}
