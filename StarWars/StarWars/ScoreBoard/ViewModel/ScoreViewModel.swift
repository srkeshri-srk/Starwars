//
//  ScoreViewModel.swift
//  StarWars
//
//  Created by Shreyansh Raj  Keshri on 17/10/23.
//

import Foundation

struct PlayerData {
    var score: Int
    var data: ScoreModel
}

class ScoreViewModel {
    //MARK: - Variables
//    private var data = [ScoreModel]()
    private var urlString = "https://www.jsonkeeper.com/b/4YJQ"
    var score = [Int: PlayerData]() //id and their details as value score inc. and match details ScoreModel

    var count: Int {
        return score.count
    }
    
    
    //MARK: - Methods
    func getDatafromAPI(completion: @escaping () -> Void) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        if let url = URL(string: urlString) {
            session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion()
                    print("Error: \(error)")
                }
                
                guard let data = data else {
                    completion()
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode([ScoreModel].self, from: data)
                    self.setDataAccordingToPlayer(data: result)
                    completion()
                } catch {
                    completion()
                }
                
                
            }.resume()
        } else {
            completion()
        }
    }
    
//    func getInfo(at index: Int) -> ScoreModel {
//        return score[index]
//    }
    
    private func setDataAccordingToPlayer(data: [ScoreModel]) {
        for value in data {
            let playerfistID = value.player1.id
            let playerfistScore = value.player1.score
            
            if score[playerfistID] == nil {
                score[playerfistID] = PlayerData(score: value.player1.score, data: value)
            } else {
                score[playerfistID]?.score += value.player1.score
            }
            
            let playerSecondID = value.player2.id
            let playerSecondScore = value.player2.score
            
            if score[playerSecondID] == nil {
                score[playerSecondID] = PlayerData(score: value.player2.score, data: value)
            } else {
                score[playerSecondID]?.score = value.player2.score
            }
        }
    }
}


