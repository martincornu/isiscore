//
//  ActionObject.swift
//  Isiscore
//
//  Created by Martin CORNU on 16/01/2019.
//  Copyright © 2019 Martin CORNU. All rights reserved.
//

import Foundation

class ActionObject: Codable {
    var minute: String
    var player: String
    var action: String
    var team: String
    
    init(minute: String, player: String, action: String, team:String) {
        self.minute = minute
        self.player = player
        self.action = action
        self.team = team
    }
}
