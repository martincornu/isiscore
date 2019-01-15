//
//  DetailsVC.swift
//  Isiscore
//
//  Created by Martin CORNU on 14/01/2019.
//  Copyright © 2019 Martin CORNU. All rights reserved.
//

import Foundation
import UIKit

class DetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    @IBOutlet weak var gameDetailsTableView: UITableView!
    
    var homeTeamName: String?
    var awayTeamName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        self.homeTeamNameLabel.text = homeTeamName
        self.awayTeamNameLabel.text = awayTeamName
        
        let indexPath = IndexPath(row: 0, section: 0)
        gameDetailsTableView.insertRows(at: [indexPath], with: .automatic)
        self.gameDetailsTableView.reloadData()
    }
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let homeCell = tableView.dequeueReusableCell(withIdentifier: "homeTeamDetailsCell", for: indexPath) as! HomeTeamDetailsCell
            
            //let game = games[indexPath.row]
            
            homeCell.timeLabel.text = "45'"
            homeCell.playerLabel.text = "Germain"
            homeCell.actionImageView.image = UIImage(named: "asse")
            return homeCell
        }
        else {
            let awayCell = tableView.dequeueReusableCell(withIdentifier: "awayTeamDetailsCell", for: indexPath) as! AwayTeamDetailsCell
            
            //let game = games[indexPath.row]
            
            awayCell.timeLabel.text = "60'"
            awayCell.playerLabel.text = "Balmont"
            awayCell.actionImageView.image = UIImage(named: "lyon")
            return awayCell
        }
    }
}
