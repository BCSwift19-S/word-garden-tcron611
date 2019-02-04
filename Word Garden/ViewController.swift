//
//  ViewController.swift
//  Word Garden
//
//  Created by Thomas Ronan on 2/3/19.
//  Copyright © 2019 Thomas Ronan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    var wordsToGuess = ["CODE", "SWIFT", "DEVICE", "TECHNOLOGY", "CLASS", "BOSTON"] //added a list of words so you can play the game more than once
    var wordToGuess: String = ""
    var lettersGuessed = ""
    let maxNumberofWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    var lostGame = false //to tell if the user lost the last round, lets program know to give you
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wordToGuess = wordsToGuess.first!
       // wordsToGuess.removeFirst()
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
    }

    func updateUIAfterGuess() {
       // guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
        guessLetterButton.isEnabled = false
    }
    
    func formatUserGuessLabel() {
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + " \(letter)"
            } else {
                revealedWord += " _"
            }
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    
    func guessALetter() {
        formatUserGuessLabel()
        guessCount += 1
        //decrements the wrongGuessesRemaining and shows the next flower image with one less petal
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed) {
            guessedLetterField.resignFirstResponder() //only close keyboard if they guess wrong
            wrongGuessesRemaining -= 1
            flowerImageView.image = UIImage(named: "flower" + "\(wrongGuessesRemaining)")
        }
        
        let revealedWord = userGuessLabel.text!
        //stop game if wrongGuessesRemaining = 0
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "So sorry, you are out of guesses!"
            lostGame = true
        } else if !revealedWord.contains("_") {
            //You've won a game
            guessedLetterField.resignFirstResponder()
            guessCountLabel.text = "You guessed the word in \(guessCount) guesses!"
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
        } else {
            //update our guess count
            let guess = ( guessCount == 1 ? "guess" : "guesses")
            guessCountLabel.text = "You've made \(guessCount) \(guess)"
        }
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
        } else {
            //disable button if I don't have a single character in the guessedLetterField
            guessLetterButton.isEnabled = false
        }
    }
    
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        guessedLetterField.resignFirstResponder()
        if wordsToGuess.count != 1 {
            if lostGame == true {
                wordToGuess = wordsToGuess.first!
            } else {
                wordsToGuess.removeFirst()
                wordToGuess = wordsToGuess.first!
            }
            lostGame = false
            playAgainButton.isHidden = true
            guessedLetterField.isEnabled = true
            guessLetterButton.isEnabled = false
            flowerImageView.image = UIImage(named: "flower8")
            wrongGuessesRemaining = maxNumberofWrongGuesses
            lettersGuessed = " "
            formatUserGuessLabel()
            guessCount = 0
            guessCountLabel.text = "You've made \(guessCount) guesses"
        } else {
            //finished guessing all of the words in the array
            userGuessLabel.text = "🤓"
            userGuessLabel.font = userGuessLabel.font.withSize(40)
            wordToGuess = ""
            playAgainButton.isHidden = true
            guessedLetterField.isHidden = true
            guessLetterButton.isHidden = true
            guessCountLabel.text = "You've guessed every word! Thanks for playing!"
        }
       
        
    }
    
    
}

