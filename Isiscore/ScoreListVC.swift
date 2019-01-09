//
//  ScoreListVC.swift
//  Isiscore
//
//  Created by Martin CORNU on 09/01/2019.
//  Copyright © 2019 Martin CORNU. All rights reserved.
//

import Foundation
import UIKit

class ScoreListVC: UITableViewController {
    
    @IBOutlet var gamesTableView: UITableView!
    
    //Tableau en dur pour test
    var games: [GameObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get data in JSON
        if let url = URL(string: "https://api.myjson.com/bins/hmyao") {
            //Background thread
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                //Parse JSON
                do {
                    let jsonDecoder = JSONDecoder()
                    let jsonObjectArray: [GameObject] = try jsonDecoder.decode([GameObject].self, from: data!)
                    
                    print("jsonObject : \(jsonObjectArray)")
                    
                    //Json mapping
                    for g in jsonObjectArray {
                        let game: GameObject = GameObject(currentTime: g.currentTime, homeTeam: g.homeTeam, homeTeamScore: g.homeTeamScore, awayTeamScore: g.awayTeamScore, awayTeam: g.awayTeam)
                        self.games.append(game)
                    }
                    
                } catch let error {
                    print("Error : \(error)")
                }
                
                //Main/UI thread
                DispatchQueue.main.async {
                    //UI modifications
                    self.gamesTableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
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
