//
//  ViewController.swift
//  Lab 4.1
//
//  Created by Tech on 2017-01-30.
//  Copyright © 2017 Tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var anagrams = [String: String]()
    
    @IBOutlet weak var anagramView: UILabel!
    @IBOutlet weak var feedback: UILabel!

    @IBOutlet weak var inputBox: UITextField!
    
    var answer:(String, String)? = nil
    
    private func generateAnagram() {
        //anagrams[s"correct"] = "scrambled"
        anagrams["test"] = "estt"
        anagrams["answer"] = "werans"
        anagrams["dog"] = "ogd"
        anagrams["computer"] = "remoctup"
        anagrams["correct"] = "scrambled"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputBox.text = " "
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SubmitClick(_ sender: UIButton) {
        if inputBox.text != "" {
            if inputBox.text?.uppercased() == answer?.0.uppercased() {
                //correct
                feedback.text = "Correct"
                let index = Int(arc4random_uniform(UInt32(anagrams.count)))
                var k = Array(anagrams.keys)
                answer = (k[index], anagrams[k[index]]!)
                anagramView.text = answer?.1
                
            } else {
                //incorrect
                feedback.text = "Incorrect"
            }
        } else {
            //first click
            answer = anagrams.first
            anagramView.text = answer?.1
            
        }
    }
    
}

