//
//  ViewController.swift
//  StarWars
//
//  Created by Shreyansh Raj  Keshri on 17/10/23.
//

import UIKit

struct PostModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var scoreViewModel = ScoreViewModel()
    
    var client = URLSessionAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        fetchData()
        
//        client.dataTask("https://www.jsonkeeper.com/b/4YJQ") { (_ result: Result<[ScoreModel], NetworkError>) in
//            switch result {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
//        
//        
//        client.dataTask("https://jsonplaceholder.typicode.com/posts/1") { (_ result: Result<PostModel, NetworkError>) in
//            switch result {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
        
        client.downloadTask("https://www.apple.com")
    }
    
    private func setupUI() {
        title = "Score Board"
        self.navigationController?.navigationBar.backgroundColor = .systemPurple
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.systemPurple]
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ScoreTableViewCell", bundle: nil), forCellReuseIdentifier: "ScoreTableViewCell")
    }
    
    private func fetchData() {
        scoreViewModel.getDatafromAPI {
            DispatchQueue.main.async {
//                self.scoreViewModel.sortedScore = scoreViewModel.score.sorted { $0.value.score > $1.value.score }
                self.tableView.reloadData()
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreTableViewCell", for: indexPath) as! ScoreTableViewCell
        if let playerData = scoreViewModel.getInfo(for: scoreViewModel.getPlayerId(for: indexPath.row)) {
            cell.configureUI(for: scoreViewModel.getPlayerId(for: indexPath.row), and: playerData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
                
        let storyBoard = UIStoryboard(name: "PlayerDetails", bundle: nil)
        let vc: PlayerDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "PlayerDetailsViewController") as! PlayerDetailsViewController
        if let scoreData = scoreViewModel.getInfo(for: scoreViewModel.getPlayerId(for: indexPath.row))?.data {
            vc.scoreData = scoreData
        }
        present(vc, animated: true)
    }
    
}

