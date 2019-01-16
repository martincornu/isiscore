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
    
    private let refreshControlScore = UIRefreshControl()
    var gamesNavigationController: UINavigationController?
    
    @IBOutlet var gamesTableView: UITableView!
    
    //Store games from JSON
    var games: [GameObject] = []
    var homeActions: [ActionObject] = []
    var awayActions: [ActionObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            self.gamesNavigationController = navigationController
        }
        
        let splashScreenVC: UIViewController! = self.storyboard?.instantiateViewController(withIdentifier: "SplashScreenVC")
        present(splashScreenVC, animated: true, completion: nil)
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControlScore
        } else {
            tableView.addSubview(refreshControlScore)
        }
        refreshControl!.addTarget(self, action: #selector(refreshScoreData(_:splashScreenVC:)), for: .valueChanged)
        
        fetchScoreData(splashScreenVC: splashScreenVC)

    }
    
    @objc private func refreshScoreData(_ sender: Any, splashScreenVC: UIViewController) {
        // Fetch Score Data
        fetchScoreData(splashScreenVC: splashScreenVC)
    }
    
    func fetchScoreData(splashScreenVC: UIViewController) {
        //Get data in JSON
        if let url = URL(string: "https://api.myjson.com/bins/18u6os") {
            //Background thread
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                
                //Parse JSON
                do {
                    let jsonDecoder = JSONDecoder()
                    let jsonObjectArray: [GameObject] = try jsonDecoder.decode([GameObject].self, from: data!)
                    
                    //Json mapping
                    self.games.removeAll() //Clear array
                    for g in jsonObjectArray {
                        let game: GameObject = GameObject(currentTime: g.currentTime, homeTeam: g.homeTeam, homeTeamScore: g.homeTeamScore, awayTeamScore: g.awayTeamScore, awayTeam: g.awayTeam, homeAction: g.homeAction, awayAction: g.awayAction)
                        
                        self.homeActions.removeAll() //Clear array
                        for homeA in g.homeAction {
                            let homeAction: ActionObject = ActionObject(minute: homeA.minute, player: homeA.player, action: homeA.action, team: homeA.team)
                            self.homeActions.append(homeAction)
                        }
                        self.awayActions.removeAll() //Clear array
                        for awayA in g.awayAction {
                            let awayAction: ActionObject = ActionObject(minute: awayA.minute, player: awayA.player, action: awayA.action, team: awayA.team)
                            self.awayActions.append(awayAction)
                        }
                        
                        self.games.append(game)
                    }
                    
                } catch let error {
                    print("Error : \(error)")
                }
                
                //Main/UI thread
                DispatchQueue.main.async {
                    //UI modifications
                    self.gamesTableView.reloadData()
                    
                    if let splashScreenVC = splashScreenVC as UIViewController? {
                        splashScreenVC.dismiss(animated: true, completion: nil)
                    }
                    
                    self.refreshControl!.endRefreshing()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC: DetailsVC! = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsVC
        
        let game = games[indexPath.row]
        detailsVC.gameObject = game
        
        self.gamesNavigationController?.pushViewController(detailsVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
}
