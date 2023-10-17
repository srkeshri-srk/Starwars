//
//  ScoreTableViewCell.swift
//  StarWars
//
//  Created by Shreyansh Raj  Keshri on 17/10/23.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    
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
    
    func configureUI() {
        reset()
        profileImageView.image = UIImage(systemName: "person.fill")
        idLabel.text = "23"
        scoreLabel.text = "Score - 100"
    }

}
