//
//  Concentration.swift
//  Concentration
//
//  Created by Denis Haritonenko on 2.03.24.
//

import Foundation

class Concentration
{
    
    private(set) var cards = [Card]()
    
    private(set) var flipCount = 0
    
    private(set) var scoreCount = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            
            // count flips
            if !cards[index].isFaceUp {
                flipCount += 1
            }
            
            // if two cards
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    //cards match
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    scoreCount += 2 - cards[index].numberOfMismatches - cards[matchIndex].numberOfMismatches
                } else {
                    // cards don't match
                    cards[matchIndex].numberOfMismatches += 1
                    cards[index].numberOfMismatches += 1
                }
                cards[index].isFaceUp = true
            } else {
                 indexOfOneAndOnlyFaceUpCard = index
            }
            
            
            
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        //TODO: Shuffle the cards
        cards.shuffle()
    }
}
