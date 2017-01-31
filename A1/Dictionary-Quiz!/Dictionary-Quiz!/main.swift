//
//  main.swift
//  Dictionary-Quiz!
//
//  Created by Tech on 2017-01-28.
//  Copyright © 2017 Tech. All rights reserved.
//

import Foundation

print("Hi! I'll give you a definition of a word, and you have to guess the word! Would you like to play? (y/es or n/o) ")

var dictionary = Dictionary()
var game:Bool = true;
var score:Int = 0;

func input() {
    var answer:String? = readLine()
    answer = answer?.lowercased()
    if  (answer == "yes" || answer == "y") {
        if (defWord()) {
            myScore()
            print ("Play again? ", terminator:"")
        } else {
            print ("Out of words!")
            game = false
        }
    } else if (answer == "no" || answer == "n") {
        game = false;
    } else {
        print("Input not recognized")
    }
}

func scoreReader() ->String {
    let file = "hs.txt"
    var highScore:String = "0"
    
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let path = dir.appendingPathComponent(file)
        
        do {
            highScore = try String(contentsOf: path, encoding: String.Encoding.utf8)
        }
        catch {print("You set the very first highscore!")}
        
        do {
            if let hsInt = Int(highScore) {
                if (score > hsInt) {
                    try String(score).write(to: path, atomically: false, encoding: String.Encoding.utf8)
                    return String(score)
                }
            }
        }
        catch {print("Error, highscore could not be written")}
    } else {
        print("Directory error, cannot get highscore")
    }
    return highScore
}

func defWord() -> Bool{
    print ("Definition: ", terminator:"");
    return (dictionary.getWord(userWord: "hi"))
}

func myScore() {
    print("Your current score is: " + String(score))
    if (!game){
        print("The high score is: " + scoreReader())
    }
}

func randomEmoji(emotion: String)->String{
    let emojiStart = 0x1F601
    var ascii:Int = 0
    if (emotion == "happy") {
        ascii = emojiStart + Int(arc4random_uniform(UInt32(11)))
    } else if (emotion == "sad") {
        ascii = emojiStart + Int(arc4random_uniform(UInt32(19)) + 35)
    }
    let emoji = UnicodeScalar(ascii)?.description
    return emoji ?? "x"
}

while (game) {
    input()
}
myScore()
print("Thanks for playing!")
