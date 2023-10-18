//
//  ScoreTableViewCell.swift
//  StarWars
//
//  Created by Shreyansh Raj  Keshri on 17/10/23.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    
    var profileImages: [String] = ["panda1", "panda2", "panda3", "panda4", "panda5", "panda6"]
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func reset() {
        profileImageView.image = nil
        idLabel.text = nil
        scoreLabel.text = nil
    }
    
    func configureUI(for playerID: Int, and info: PlayerData) {
        reset()
        profileImageView.image = UIImage(named: profileImages.randomElement() ?? "panda1")
        idLabel.text = String(playerID)
        scoreLabel.text = "Score - \(info.score)"
    }

}
