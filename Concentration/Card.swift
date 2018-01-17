//
//  Card.swift
//  Concentration
//
//  Created by Samuel Evans-Powell on 17/1/18.
//  Copyright © 2018 Samuel Evans-Powell. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
