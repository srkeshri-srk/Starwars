//
//  ViewController.swift
//  StarWars
//
//  Created by Shreyansh Raj  Keshri on 17/10/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var scoreViewModel = ScoreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        fetchData()
    }
    
    private func setupUI() {
        title = "Score Board"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ScoreTableViewCell", bundle: nil), forCellReuseIdentifier: "ScoreTableViewCell")
    }
    
    private func fetchData() {
        scoreViewModel.getDatafromAPI {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(scoreViewModel.count)
        return scoreViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreTableViewCell", for: indexPath) as! ScoreTableViewCell
        cell.configureUI()
//        print(scoreViewModel.getInfo(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

