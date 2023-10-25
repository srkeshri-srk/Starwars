//
//  ScoreViewModel.swift
//  StarWars
//
//  Created by Shreyansh Raj  Keshri on 17/10/23.
//

import Foundation

final class ScoreViewModel {
    //MARK: - Variables
    private var urlString: String
    private var urlSession = URLSessionAPIClient()
    var score = [Int: PlayerData]()
    var playerID = [Int]()
    
    var count: Int {
        return score.count
    }
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    //MARK: - Methods
    func getDatafromAPI(completion: @escaping () -> Void) {
        urlSession.dataTask(urlString) { [weak self] (_ result: Result<[ScoreModel], NetworkError>) in
            guard let self = self else {
                completion()
                return
            }
            
            switch result {
            case .success(let success):
                self.setDataAccordingToPlayer(data: success)
                completion()
            case .failure(let failure):
                print(failure.localizedDescription)
                completion()
            }
        }
    }
    
    func getInfo(for playerID: Int) -> PlayerData? {
        return score[playerID]
    }
    
    func getPlayerId(for index: Int) -> Int {
        return playerID[index]
    }
}


private extension ScoreViewModel {
    func storePlayerID(with value: Int) {
        if !playerID.contains(value) {
            playerID.append(value)
        }
    }
    
    func setDataAccordingToPlayer(data: [ScoreModel]) {
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

extension ScoreViewModel {
    static func build() -> ScoreViewModel {
        ScoreViewModel(urlString: "https://www.jsonkeeper.com/b/4YJQ")
    }
}
