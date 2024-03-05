//
//  Card.swift
//  Concentration
//
//  Created by Denis Haritonenko on 2.03.24.
//

import Foundation

struct Card: Hashable
{
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
    var isFaceUp = false
    var isMatched = false
    var numberOfMismatches = 0
    private var identifier: Int
        
    private static var identifierFactory = 0
    
    
    private static func getUniqueIdentifier() -> Int {
            identifierFactory += 1
            return identifierFactory
    }
    
    init() {
        identifier = Card.getUniqueIdentifier()
    }
}




