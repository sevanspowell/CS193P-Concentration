//
//  Concentration.swift
//  Concentration
//
//  Created by Samuel Evans-Powell on 17/1/18.
//  Copyright © 2018 Samuel Evans-Powell. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var flipCount = 0
    
    init(numberOfPairsOfCards: Int) {
        generateCards(numberOfPairsOfCards: numberOfPairsOfCards)
        shuffleCards()
    }
    
    func chooseCard(at index: Int) {
        flipCount += 1

        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // Only one card face up
                
                // Flip up the card we chose
                cards[index].isFaceUp = true
                
                // Check if new card and current card match
                if cards[matchIndex].identifier == cards[index].identifier {
                    // If they do, update matched state
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched        = true
                }

                // Update state of card index cache
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // Either no cards or 2 cards are face up
                
                faceDownAllCards()

                // Flip up chosen card
                cards[index].isFaceUp = true
                
                // Update state of card index cache
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func isGameOver() -> Bool {
        return cards.reduce(true, { $0 && $1.isMatched })
    }

    private func generateCards(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            
            // Add card and matching card
            cards += [card, card]
        }
    }
    
    private func shuffleCards() {
        cards.shuffle()
    }
    
    private func faceDownAllCards() {
        cards = cards.map { var card = $0; card.isFaceUp = false; return card }
    }
}

extension MutableCollection {
    // Shuffle the elements
    //     Implementation of Fisher-Yates shuffle - O(n)
    //     (https://en.wikipedia.org/wiki/Fisher–Yates_shuffle)
    mutating func shuffle() {
        let cnt:Int = -count.distance(to: 0)
        
        // No need to shuffle array of 1 element
        guard cnt > 1 else {
            return
        }
        
        // Obtain a random integer
        func randomInt(betweenInclusive start: Int, andInclusive end: Int) -> Int {
            return Int(arc4random_uniform(UInt32(abs(end - start) + 1))) + Swift.min(start, end)
        }
        
        for i in stride(from: cnt - 1, through: 1, by: -1) {
            let j = randomInt(betweenInclusive: 0, andInclusive: i)
            let iIndex = self.index(self.startIndex, offsetBy: IndexDistance(i))
            let jIndex = self.index(self.startIndex, offsetBy: IndexDistance(j))
            self.swapAt(jIndex, iIndex)
        }
    }
}
