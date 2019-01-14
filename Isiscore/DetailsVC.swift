//
//  DetailsVC.swift
//  Isiscore
//
//  Created by Martin CORNU on 14/01/2019.
//  Copyright © 2019 Martin CORNU. All rights reserved.
//

import Foundation
import UIKit

class DetailsVC: UIViewController {
    
    @IBOutlet weak var homeTeamNameLabel: UILabel!
    @IBOutlet weak var awayTeamNameLabel: UILabel!
    
    var homeTeamName: String?
    var awayTeamName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        self.homeTeamNameLabel.text = homeTeamName
        self.awayTeamNameLabel.text = awayTeamName
    }
}
