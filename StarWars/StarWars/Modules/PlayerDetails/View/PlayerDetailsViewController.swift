//
//  PlayerDetailsViewController.swift
//  StarWars
//
//  Created by Shreyansh Raj  Keshri on 18/10/23.
//

import UIKit

class PlayerDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var scoreData = [ScoreModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PlayerDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayerDetailsTableViewCell")
    }

}

extension PlayerDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerDetailsTableViewCell", for: indexPath) as! PlayerDetailsTableViewCell
        cell.configureUI(with: scoreData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


