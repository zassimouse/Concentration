//
//  ViewController.swift
//  Concentration
//
//  Created by Denis Haritonenko on 1.03.24.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int { return (cardButtons.count + 1) / 2 }
    
    private let themes = [
        "🍒🍏🍌🍊🫐🍇",
        "🍆🍅🥬🥕🌶️🥒",
        "🦒🐈‍⬛🐇🐁🐖🐆",
        "❤️🧡💛💚💙💜",
        "🇮🇹🇪🇪🇬🇷🇸🇪🇺🇸🇨🇭",
        "👠🩳👜👕👖👟",
    ]
    
    private lazy var emojiChoises = themes[themes.count.arc4random]

    @IBOutlet weak var scoreCountLabel: UILabel!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardnumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardnumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        // new game class
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        // new cards
        emojiChoises = themes[themes.count.arc4random]
        //clean old game
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(getEmoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.systemGray5
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.systemGreen
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreCountLabel.text = "Score: \(game.scoreCount)"
    }
    
    private var emoji: [Card: String] = [:]
    
    private func getEmoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoises.count > 0 {
            let randomIndex = emojiChoises.index(emojiChoises.startIndex, offsetBy: emojiChoises.count.arc4random)
            emoji[card] = String(emojiChoises.remove(at: randomIndex))
        }
        return emoji[card] ?? "?"
    }
}



extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

