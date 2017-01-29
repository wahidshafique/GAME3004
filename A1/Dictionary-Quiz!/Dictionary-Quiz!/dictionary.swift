//
//  dictionary.swift
//  Dictionary-Quiz!
//
//  Created by Tech on 2017-01-28.
//  Copyright © 2017 Tech. All rights reserved.
//

import Foundation


class Dictionary {
    public var dict: [String:String] = [
        "word" : "test",
        "word2" : "test2",
        "word3" : "test3"
    ]
    
    func getWord(userWord: String) -> Bool{
        if (self.dict.count > 0) {
            let index: Int = Int(arc4random_uniform(UInt32(self.dict.count)))
            let key: String = Array(self.dict.keys)[index]
            let value: String = Array(self.dict.values)[index]
            print(value)
            let userGuess:String? = readLine()
            if let i = self.dict.removeValue(forKey: key) {
                print ("The value \(i) was removed.")
                if (userGuess?.lowercased() == key) {
                    print ("correct")

                } else {
                    print("wrong")
                }
            }
            return true
        }
        return false
    }
}
