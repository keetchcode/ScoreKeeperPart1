//
//  AddPlayerViewController.swift
//  ScoreKeeperPart1
//
//  Created by Wesley Keetch on 11/18/24.
//

import UIKit

protocol AddPlayerDelegate: AnyObject {
  func didAddPlayer(_ player: Player)
}

class AddPlayerViewController: UIViewController {

  @IBOutlet weak var newPlayerLabel: UITextField!
  @IBOutlet weak var newPlayerScoreLabel: UITextField!

  weak var delegate: AddPlayerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
  }

  // MARK: - Configure View

  private func configureView() {
    title = "Add Player"
    newPlayerLabel.placeholder = "Enter player name"
    newPlayerScoreLabel.placeholder = "Enter player score"
    newPlayerScoreLabel.keyboardType = .numberPad
  }

  // MARK: - Save Player Action

  @IBAction func savePlayerButtonTapped(_ sender: UIButton) {
    guard let name = newPlayerLabel.text, !name.isEmpty else {
      presentErrorAlert(message: "Please enter a valid player name.")
      return
    }

    guard let scoreText = newPlayerScoreLabel.text, let score = Int(scoreText), score >= 0 else {
      presentErrorAlert(message: "Please enter a valid score (0 or greater).")
      return
    }

    let newPlayer = Player(name: name, score: score, image: "player", description: "")
    delegate?.didAddPlayer(newPlayer)
    navigationController?.popViewController(animated: true)
  }

  // MARK: - Helper Methods

  private func presentErrorAlert(message: String) {
    let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}
