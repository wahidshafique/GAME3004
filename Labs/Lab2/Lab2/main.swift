//
//  main.swift
//  Lab2
//
//  Created by C410 on 2017-01-23.
//  Copyright © 2017 GBC. All rights reserved.
//

import Foundation

struct Board {
    var fields: Array<String?>
    
    init() {
        self.fields = Array<String?>()
        for _ in 1...9 {
            fields.append(Mark.empty.rawValue)
        }
    }
    
    mutating func move(_ index: Int, mark: Mark) -> Bool{
        var isOver = checkIfGameOver()
        if !isOver{
            if self.fields[index] == Mark.empty.rawValue {
                self.fields[index] = mark.rawValue
            } else {
                print("Invalid move by \(mark): \(index) is already occupied")
            }
            printBoard()
            isOver = checkIfGameOver(true)
        }else{
            isOver = checkIfGameOver(true)
        }
        
        return isOver
        
    }
    
    mutating func move(_ coordinate: (Int, Int), mark: Mark) -> Bool{
        print("Move: ", mark.rawValue, "->", coordinate )
        
        return self.move(index(coordinate)!, mark: mark)
    }
    
    func checkIfGameOver(_ doPrint:Bool = false)->Bool {
        let winner = self.winner()
        
        if let w = winner {
            if doPrint {
                print("We have a winner: \(w)")
            }
            return true
        } else {
            if doPrint {
                print("no winner")
            }
            return false
        }
    }
    
    func winner() -> String? {
        let rowOwners: Array<String?> = [
            self.ownerOfRow((0,0), add: (1,0)), //first column
            self.ownerOfRow((0,0), add: (0,1)), //first row
            self.ownerOfRow((0,0), add: (1,1)), //diagonal right \
            self.ownerOfRow((0,2), add: (1,-1)), //diagonal left /
            
            
            self.ownerOfRow((1,0), add: (0,1)), //second column
            self.ownerOfRow((2,0), add: (0,1)), //third column
            
            self.ownerOfRow((0,1), add: (1,0)), //second row
            self.ownerOfRow((0,2), add: (1,0)), //third row
        ]
        
        return rowOwners.reduce(nil, { (winnerSoFar: String?, currentMark: String?) in
            if let actualWinnerSoFar = winnerSoFar {
                return actualWinnerSoFar
            } else {
                return currentMark
            }
        });
    }
    
    func index(_ coordinate: (Int, Int)) -> Int? {
        let (x,y) = coordinate
        
        if x >= 3 || y >= 3 {
            return nil
        }
        
        return y * 3 + x
    }
    
    func exists(_ coordinate: (Int,Int)) -> Bool {
        return self.index(coordinate) != nil
    }
    
    func ownerOfRow(_ initial: (Int, Int), add: (Int, Int)) -> String? {
        let (x,y) = initial
        let (addX, addY) = add
        
        let initialMark = self.fields[self.index(initial)!]
        let next = (x+addX, y+addY)
        
        if exists(next) {
            let nextFieldMark = self.ownerOfRow(next, add: add)
            if nextFieldMark == initialMark && initialMark != Mark.empty.rawValue{
                return nextFieldMark
            } else {
                return nil
            }
        } else {
            return initialMark
        }
    }
    
    func printBoard(){
        print(" ", 0, 1, 2)
        print(0, (fields[0] != nil) ? fields[0]! : "_", (fields[1] != nil) ? fields[1]! : "_", (fields[2] != nil) ? fields[2]! : "_")
        print(1, (fields[3] != nil) ? fields[3]! : "_", (fields[4] != nil) ? fields[4]! : "_", (fields[5] != nil) ? fields[5]! : "_")
        print(2, (fields[6] != nil) ? fields[6]! : "_", (fields[7] != nil) ? fields[7]! : "_", (fields[8] != nil) ? fields[8]! : "_")
        print(" ")
    }
}

enum Mark:String{
    case X
    case O
    case empty = "_"
}

// Let's play a game of TicTacToe
var b = Board()

func askForInput()->(Int,Int){
    var sCol:String? = nil
    var iCol:Int? = nil
    
    while sCol==nil || iCol==nil {
        print("Enter the column (1..3)")
        sCol = readLine()
        iCol = Int(sCol!)
        if iCol!<0 || iCol!>3{
            iCol = nil
        }
    }
    
    var sRow:String? = nil
    var iRow:Int? = nil
    
    while sRow==nil || iRow==nil {
        print("Enter the row (1..3)")
        sRow = readLine()
        iRow = Int(sRow!)
        if iRow!<0 || iRow!>2{
            iRow = nil
        }
        
    }
    
    return (iCol!, iRow!)
}


var isOver = false
var lastMoving = Mark.O
while !isOver {
    switch lastMoving {
    case Mark.X:
        lastMoving = Mark.O
    case Mark.O:
        lastMoving = Mark.X
    default:
        lastMoving=Mark.X
    }
    print("Now playing \(lastMoving.rawValue)")
    var move = askForInput()
    isOver = b.move(move, mark: lastMoving)
    
}


