//
//  AddPlayerViewController.swift
//  ScoreKeeperPart1
//
//  Created by Wesley Keetch on 11/18/24.
//

import UIKit

class AddPlayerViewController: UIViewController {
  
  @IBOutlet weak var newPlayerLabel: UITextField!
  @IBOutlet weak var newScoreLabel: UITextField!
  
  weak var delegate: AddPlayerDelegate?
  
  protocol AddPlayerDelegate: AnyObject {
    func didAddPlayer(_ player: Player)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func saveButtonTapped(_ sender: UIButton) {
    guard let name = newPlayerLabel.text, !name.isEmpty,
          let scoreText = newScoreLabel.text, let score = Int(scoreText) else
    {
      return
    }
    
    let newPlayer = Player(name: name, score: score, image: "ryan", description: "")
    delegate?.didAddPlayer(newPlayer)
    navigationController?.popViewController(animated: true)
  }
}



