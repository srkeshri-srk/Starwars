//
//  ScoreViewModel.swift
//  StarWars
//
//  Created by Shreyansh Raj  Keshri on 17/10/23.
//

import Foundation

class ScoreViewModel {
    //MARK: - Variables
    private var urlString = "https://www.jsonkeeper.com/b/4YJQ"
    var score = [Int: PlayerData]() //id and their details as value score inc. and match details ScoreModel
    var sortedScore = Array(arrayLiteral: [Int: PlayerData]()) // temp
    var playerID = [Int]()
    
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
    
    func getInfo(for playerID: Int) -> PlayerData? {
        return score[playerID]
    }
    
    func getPlayerId(for index: Int) -> Int {
        return playerID[index]
    }
    
    private func storePlayerID(with value: Int) {
        if !playerID.contains(value) {
            playerID.append(value)
        }
    }
    
    private func setDataAccordingToPlayer(data: [ScoreModel]) {
        for value in data {
            let fistPlayerID = value.player1.id
            storePlayerID(with: fistPlayerID)
            
            if score[fistPlayerID] == nil {
                score[fistPlayerID] = PlayerData(score: value.player1.score, data: [value])
            } else {
                score[fistPlayerID]?.score += value.player1.score
                score[fistPlayerID]?.data.append(value)
            }
            
            let secondPlayerID = value.player2.id
            storePlayerID(with: secondPlayerID)
            
            if score[secondPlayerID] == nil {
                score[secondPlayerID] = PlayerData(score: value.player2.score, data: [value])
            } else {
                score[secondPlayerID]?.score += value.player2.score
                score[secondPlayerID]?.data.append(value)
            }
        }
    }
}


