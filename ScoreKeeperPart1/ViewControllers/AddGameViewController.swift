//
//  AddGameViewController.swift
//  ScoreKeeperPart1
//
//  Created by Wesley Keetch on 11/19/24.
//

import UIKit

class AddGameViewController: UIViewController {

  @IBOutlet weak var newGameLabel: UITextField!
  @IBOutlet weak var newGameScoreLabel: UITextField!

  weak var delegate: AddPlayerDelegate?

  protocol AddPlayerDelegate: AnyObject {
    func didAddPlayer(_ player: Player)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func saveGameButtonTapped(_ sender: UIButton) {
    guard let name = newGameLabel.text, !name.isEmpty,
          let scoreText = newGameScoreLabel.text, let score = Int(scoreText) else
    {
      return
    }

    let newPlayer = Player(name: name, score: score, image: "", description: "")
    delegate?.didAddPlayer(newPlayer)
    navigationController?.popViewController(animated: true)
  }
}
