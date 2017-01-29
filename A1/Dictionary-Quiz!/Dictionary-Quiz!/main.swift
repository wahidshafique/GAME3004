//
//  main.swift
//  Dictionary-Quiz!
//
//  Created by Tech on 2017-01-28.
//  Copyright © 2017 Tech. All rights reserved.
//

import Foundation

print("Hello, World!")

var dictionary = Dictionary()
var game:Bool = true;

func input() {
    var answer:String? = readLine()
    answer = answer?.lowercased()
    if  (answer == "yes") {
        _ = defWord()
        print ("Play again? ", terminator:"")
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
