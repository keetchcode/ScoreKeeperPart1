//
//  AddGameViewController.swift
//  ScoreKeeperPart1
//
//  Created by Wesley Keetch on 11/19/24.
//

import UIKit

protocol AddGameDelegate: AnyObject {
  func didAddGame(_ game: Game)
}

class AddGameViewController: UIViewController {
  
  @IBOutlet weak var newGameScoreLabel: UITextField!
  @IBOutlet weak var newGameLabel: UITextField!
  @IBOutlet weak var scoringRuleSegmentedControl: UISegmentedControl!
  @IBOutlet weak var playersTableView: UITableView!
  
  weak var delegate: AddGameDelegate?
  
  var players: [Player] = []
  var selectedPlayers: [Player] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    
    players = [
      Player(name: "Mike", score: 100, image: "player1", description: ""),
      Player(name: "Ryan", score: 80, image: "player2", description: ""),
      Player(name: "Nathan", score: 60, image: "player3", description: "")
    ]
    
    playersTableView.reloadData()
  }
  
  // MARK: - Configure View
  private func configureView() {
    title = "Add Game"
    
    newGameLabel.placeholder = "Enter game name"
    
    scoringRuleSegmentedControl.setTitle("Highest Score", forSegmentAt: 0)
    scoringRuleSegmentedControl.setTitle("Lowest Score", forSegmentAt: 1)
    
    playersTableView.dataSource = self
    playersTableView.delegate = self
  }
  
  // MARK: - Save Game Action
  @IBAction func saveGameButtonTapped(_ sender: UIButton) {
    guard let gameName = newGameLabel.text, !gameName.isEmpty else {
      presentErrorAlert(message: "Please enter a valid game name.")
      return
    }
    
    guard !selectedPlayers.isEmpty else {
      presentErrorAlert(message: "Please select at least one player for the game.")
      return
    }
    
    let scoringRule = (scoringRuleSegmentedControl.selectedSegmentIndex == 0) ? "Highest Score" : "Lowest Score"
    
    let newGame = Game(
      gameType: gameName,
      score: 0,
      image: "game",
      description: scoringRule,
      players: selectedPlayers
    )
    
    delegate?.didAddGame(newGame)
    navigationController?.popViewController(animated: true)
  }
  
  // MARK: - Helper Methods
  private func presentErrorAlert(message: String) {
    let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

// MARK: - Table View Data Source & Delegate
extension AddGameViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return players.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)
    
    let player = players[indexPath.row]
    cell.textLabel?.text = player.name
    cell.detailTextLabel?.text = "Score: \(player.score)"
    cell.accessoryType = selectedPlayers.contains(where: { $0.id == player.id }) ? .checkmark : .none
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedPlayer = players[indexPath.row]
    
    if let index = selectedPlayers.firstIndex(where: { $0.id == selectedPlayer.id }) {
      selectedPlayers.remove(at: index)
    } else {
      selectedPlayers.append(selectedPlayer)
    }
    
    tableView.reloadRows(at: [indexPath], with: .automatic)
  }
}
