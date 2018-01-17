//
//  ViewController.swift
//  Concentration
//
//  Created by Samuel Evans-Powell on 15/1/18.
//  Copyright © 2018 Samuel Evans-Powell. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    let emojiThemes = [
        "halloween":    ["🎃", "👻", "😈", "🦇", "🕯", "🍭", "🍬", "🧛🏻‍♂️", "🐉", "🕷"],
        "fruit":        ["🍏", "🍎", "🍉", "🥑", "🍍", "🌶", "🍌", "🍇", "🥥", "🍆"],
        "construction": ["🚧", "🏭", "🏗", "🚦", "🚚", "🚛", "🚨", "🏛", "🛤", "🛣"],
        ]
    
    var emojiChoices:[String] = []
    
    var emoji = [Int:String]()
    
    override func viewDidLoad() {
        startNewGame()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        let cardNumber = cardButtons.index(of: sender)!

        game.chooseCard(at: cardNumber)
        updateViewFromModel()
    }

    
    @IBAction func touchNewGame(_ sender: UIButton) {
        startNewGame()
    }
    
    func startNewGame() {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        populateEmojiChoices()
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"

        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.6837917343, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.6837917343, blue: 0, alpha: 1)
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    func populateEmojiChoices() {
        let themeKeys = Array(emojiThemes.keys)
        let themeIndex = Concentration.random_uniform_from_zero(toExclusive: themeKeys.count)
        let theme = themeKeys[themeIndex]
        emojiChoices = emojiThemes[theme]!
    }
}

