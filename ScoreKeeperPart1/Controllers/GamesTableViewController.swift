//
//  GamesTableViewController.swift
//  ScoreKeeperPart1
//
//  Created by Wesley Keetch on 11/19/24.
//

import UIKit

class GamesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddGameDelegate {

  @IBOutlet weak var gamesTableView: UITableView!

  var games: [Game] = []

  override func viewDidLoad() {
    super.viewDidLoad()

    gamesTableView.dataSource = self
    gamesTableView.delegate = self

    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addGameButtonTapped))
    navigationItem.rightBarButtonItem = addButton

    games = [
      Game(
        gameType: "Chess",
        score: 0,
        image: "chess",
        description: "Highest Score",
        players: [
          Player(name: "Mike", score: 100, image: "player1", description: ""),
          Player(name: "Ryan", score: 80, image: "player2", description: "")
        ]
      ),
      Game(
        gameType: "Poker",
        score: 0,
        image: "poker",
        description: "Lowest Score",
        players: [
          Player(name: "Alice", score: 10, image: "player3", description: ""),
          Player(name: "Bob", score: 20, image: "player4", description: "")
        ]
      )
    ]

    print("Games array initialized with \(games.count) items")

    gamesTableView.reloadData()
  }

  // MARK: - Table View Data Source

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return games.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)

    let game = games[indexPath.row]

    cell.textLabel?.text = game.gameType
    cell.detailTextLabel?.text = "Leader: \(determineLeader(for: game))"

    return cell
  }

  // MARK: - Table View Delegate

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    if let scoreKeeperVC = storyboard.instantiateViewController(withIdentifier: "ScoreKeeperViewController") as? ScoreKeeperViewController {
      let selectedGame = games[indexPath.row]

      scoreKeeperVC.game = selectedGame
      scoreKeeperVC.players = selectedGame.players

      print("Navigated to ScoreKeeperViewController with game: \(selectedGame.gameType)")

      navigationController?.pushViewController(scoreKeeperVC, animated: true)
    } else {
      print("Error: Could not instantiate ScoreKeeperViewController.")
    }
  }

  // MARK: - Add Game Button Action

  @objc func addGameButtonTapped() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    if let addGameVC = storyboard.instantiateViewController(withIdentifier: "AddGameViewController") as? AddGameViewController {
      addGameVC.delegate = self
      navigationController?.pushViewController(addGameVC, animated: true)
    } else {
      print("Error: Could not instantiate AddGameViewController.")
    }
  }

  // MARK: - Helper Methods

  private func determineLeader(for game: Game) -> String {
    guard let leader = game.players.max(by: { $0.score < $1.score }) else {
      return "No players"
    }
    return leader.name
  }

  // MARK: - AddGameDelegate

  func didAddGame(_ game: Game) {
    games.append(game)
    gamesTableView.reloadData()
  }
}
