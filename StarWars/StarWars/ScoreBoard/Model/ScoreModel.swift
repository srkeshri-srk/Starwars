//
//  ScoreModel.swift
//  StarWars
//
//  Created by Shreyansh Raj  Keshri on 17/10/23.
//

import Foundation


//MARK: - Score Model
struct ScoreModel: Codable {
    var match: Int
    var player1: Player
    var player2: Player
}


//MARK: - Player Model
struct Player: Codable {
    var id: Int
    var score: Int
}
