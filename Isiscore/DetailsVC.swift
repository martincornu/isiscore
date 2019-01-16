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
    @IBOutlet weak var homeBadgeImageView: UIImageView!
    @IBOutlet weak var awayBadgeImageView: UIImageView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var homeScoreLabel: UILabel!
    @IBOutlet weak var awayScoreLabel: UILabel!
    
    
    var gameObject: GameObject?
    var homeActions: [ActionObject]?
    var awayActions: [ActionObject]?
    var allActions: [ActionObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeActions = self.gameObject?.homeAction
        self.awayActions = self.gameObject?.awayAction
        self.allActions = self.homeActions! + self.awayActions!
        self.allActions?.sort(by: { $0.minute > $1.minute })
        
        updateUI()
    }
    
    func updateUI() {
        self.homeTeamNameLabel.text = gameObject?.homeTeam
        self.awayTeamNameLabel.text = gameObject?.awayTeam
        self.homeBadgeImageView.image = UIImage(named: (self.gameObject?.homeTeam)!)
        self.awayBadgeImageView.image = UIImage(named: (self.gameObject?.awayTeam)!)
        self.currentTimeLabel.text = gameObject?.currentTime
        self.homeScoreLabel.text = gameObject?.homeTeamScore
        self.awayScoreLabel.text = gameObject?.awayTeamScore
        
        self.gameDetailsTableView.reloadData()
    }
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var nbActions: Int = 0
        
        if let actions = self.allActions as [ActionObject]? {
            nbActions = actions.count
        }
        
        return nbActions
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let action: ActionObject = self.allActions![indexPath.row]
        
        if action.team == "home" {
            let homeCell = tableView.dequeueReusableCell(withIdentifier: "homeTeamDetailsCell", for: indexPath) as! HomeTeamDetailsCell
            
            homeCell.timeLabel.text = "\(action.minute)'"
            homeCell.playerLabel.text = action.player
            homeCell.actionImageView.image = UIImage(named: (action.action))
            
            return homeCell
        }
        else {
            let awayCell = tableView.dequeueReusableCell(withIdentifier: "awayTeamDetailsCell", for: indexPath) as! AwayTeamDetailsCell
            
            awayCell.timeLabel.text = "\(action.minute)'"
            awayCell.playerLabel.text = action.player
            awayCell.actionImageView.image = UIImage(named: (action.action))
            
            return awayCell
        }
    }
}
