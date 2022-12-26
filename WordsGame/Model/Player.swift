//
//  Player.swift
//  WordsGame
//
//  Created by Yusup Aliskantiev on 15.12.2022.
//

import Foundation

struct Player {
    let name: String
   private(set) var score: Int = 0
    
    
    mutating func add(score: Int) {
        self.score += score
    }
    
}
