//
//  GameObject.swift
//  Isiscore
//
//  Created by Martin CORNU on 09/01/2019.
//  Copyright © 2019 Martin CORNU. All rights reserved.
//

import Foundation

class GameObject: Codable {
    var currentTime: String
    var homeTeam: String
    var homeTeamScore: String
    var awayTeamScore: String
    var awayTeam: String
    var homeAction: [ActionObject]
    var awayAction: [ActionObject]
    
    init(currentTime: String, homeTeam: String, homeTeamScore: String, awayTeamScore: String, awayTeam:String, homeAction: [ActionObject], awayAction: [ActionObject]) {
        self.currentTime = currentTime
        self.homeTeam = homeTeam
        self.homeTeamScore = homeTeamScore
        self.awayTeamScore = awayTeamScore
        self.awayTeam = awayTeam
        self.homeAction = homeAction
        self.awayAction = awayAction
    }
}
