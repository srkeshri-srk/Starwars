//
//  PlayerDetailsTableViewCell.swift
//  StarWars
//
//  Created by Shreyansh Raj  Keshri on 18/10/23.
//

import UIKit

enum MatchStatus {
    case win
    case loss
    case draw
}

class PlayerDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var player1Label: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var player2Label: UILabel!
    
    var matchStatus: MatchStatus = .draw {
        didSet {
            switch self.matchStatus {
            case .win:
                setupWinUI()
            case .loss:
                setupLossUI()
            case .draw:
                setupDrawUI()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
        
    private func reset() {
        outerView.backgroundColor = .white
        player1Label.text = nil
        player2Label.text = nil
        scoreLabel.text = nil
    }
    
    func configureUI(with data: ScoreModel) {
        reset()
        player1Label.text = String(data.player1.id)
        player2Label.text = String(data.player2.id)
        scoreLabel.text = "\(data.player1.score) - \(data.player2.score)"
        
        if data.player1.score > data.player2.score {
            matchStatus = .win
        } else if data.player1.score < data.player2.score {
            matchStatus = .loss
        } else {
            matchStatus = .draw
        }
    }
    
    private func setupUI() {
        outerView.layer.cornerRadius = 8.0
        outerView.layer.borderWidth = 2.0
        outerView.layer.masksToBounds = true
    }

    
    private func setupWinUI() {
        outerView.backgroundColor = UIColor(red: 122/255, green: 189/255, blue: 145/255, alpha: 1.0)
        player1Label.textColor = .white
        player2Label.textColor = .white
        scoreLabel.textColor = .white
        outerView.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupLossUI() {
        outerView.backgroundColor = UIColor(red: 255/255, green: 137/255, blue: 137/255, alpha: 1.0)
        player1Label.textColor = .white
        player2Label.textColor = .white
        scoreLabel.textColor = .white
        outerView.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupDrawUI() {
        outerView.backgroundColor = .white
        player1Label.textColor = .black
        player2Label.textColor = .black
        scoreLabel.textColor = .black
        outerView.layer.borderColor = UIColor.black.cgColor
    }
    
}
