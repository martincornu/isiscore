//
//  ScoreListVC.swift
//  Isiscore
//
//  Created by Martin CORNU on 09/01/2019.
//  Copyright © 2019 Martin CORNU. All rights reserved.
//

import Foundation
import UIKit

struct Game {
    var currentTime: String
    var homeTeam: String
    var homeTeamScore: String
    var awayTeamScore: String
    var awayTeam: String
    
    init(currentTime: String, homeTeam: String, homeTeamScore: String, awayTeamScore: String, awayTeam:String) {
        self.currentTime = currentTime
        self.homeTeam = homeTeam
        self.homeTeamScore = homeTeamScore
        self.awayTeamScore = awayTeamScore
        self.awayTeam = awayTeam
    }
    
}

class ScoreListVC: UITableViewController {
    
    let game1: Game = Game(currentTime: "TER", homeTeam: "Clermont", homeTeamScore: "3", awayTeamScore: "0", awayTeam: "Tourcoing")
    
    let game2: Game = Game(currentTime: "66\'", homeTeam: "Lyon", homeTeamScore: "0", awayTeamScore: "4", awayTeam: "Saint-Etienne")
    
    //Tableau en dur pour test
    var games: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        games.append(game1)
        games.append(game2)
    }

    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        //A remplacer par nombre de matchs
    }
    
    override func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath) as! ScoreCell
        
        let game = games[indexPath.row]
        
        cell.currentTime.text = game.currentTime
        cell.homeTeam.text = game.homeTeam
        cell.homeTeamScore.text = game.homeTeamScore
        cell.awayTeamScore.text = game.awayTeamScore
        cell.awayTeam.text = game.awayTeam
        
        return cell
    }
    
}
