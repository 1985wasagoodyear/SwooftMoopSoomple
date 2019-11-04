//
//  CardinalDirection.swift
//  SwooftMoopSoomple
//
//  Created by K Y on 11/3/19.
//  Copyright © 2019 K Y. All rights reserved.
//

import Foundation

enum CardinalDirection: CaseIterable {
    case east, south, west, north
    
    /// chooses a random direction
    static var random: CardinalDirection {
        let allCases = CardinalDirection.allCases
        let i = Int.random(in: 0..<allCases.count)
        return allCases[i]
    }
}
