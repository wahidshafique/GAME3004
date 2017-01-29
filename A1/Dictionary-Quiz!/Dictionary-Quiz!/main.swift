//
//  main.swift
//  Dictionary-Quiz!
//
//  Created by Tech on 2017-01-28.
//  Copyright © 2017 Tech. All rights reserved.
//

import Foundation

func randomEmoji(emotion: String)->String{
    //just for fun :)
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

print("sad emoji: " + randomEmoji(emotion: "sad"))
print("happy emoji: " + randomEmoji(emotion: "happy"))
print("Hi! I'll give you a definition of a word, and you have to guess the word! Would you like to play? ")

var dictionary = Dictionary()
var game:Bool = true;

func input() {
    var answer:String? = readLine()
    answer = answer?.lowercased()
    if  (answer == "yes") {
        if (defWord()) {
            print ("Play again? ", terminator:"")
        } else {
            print ("Out of words!")
            game = false
        }
    } else if (answer == "no"){
        print("bad")
        game = false;
    } else {
        print("Input not recognized")
    }
}

func defWord() -> Bool{
    print ("Definition: ", terminator:"");
    return (dictionary.getWord(userWord: "hi"))
}

while (game){
    input()
}

print("Thanks for playing!")
