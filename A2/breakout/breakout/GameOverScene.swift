import Foundation
import SpriteKit
import GameplayKit

class GameOverScene: SKScene {
    init (size: CGSize, didYouWin: Bool) {
        super.init(size:size)
        
        //make the ending text
        let overLabel = SKLabelNode(fontNamed: "Arial")
        
        overLabel.fontSize = 50
        overLabel.verticalAlignmentMode = .top
        overLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        if didYouWin {
            overLabel.text = "You Won!" + randomEmoji(emotion: "happy")
        } else {
            overLabel.text = "You Lost!" + randomEmoji(emotion: "sad")
        }
        
        let hint = SKLabelNode(fontNamed: "Arial")
        
        hint.fontSize = 25
        hint.verticalAlignmentMode = .top
        hint.position = CGPoint(x: self.size.width / 2, y: self.size.height / 3)
        hint.text = "Touch to return"
        
        
        let randomThing = randomParser()

        self.addChild(randomThing)
        self.addChild(hint)
        self.addChild(overLabel)
        
            }
    
    required init? (coder decoder:NSCoder) {
        super.init(coder: decoder)
    }
    
    override func touchesBegan (_ touches: Set<UITouch>, with event: UIEvent?) {
        let startScene = MainSceneScreen(size: self.size)
        self.view?.presentScene(startScene)
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
    
    func randomParser () ->SKNode {
        
        workWithScore(mScore: 5)
        
        
        let parsed = SKNode()
        let a = SKLabelNode(fontNamed: "Arial")
        a.fontSize = 16
        let b = SKLabelNode(fontNamed: "Arial")
        b.fontSize = 16
        
        let st1 = "Line 1"
        let st2 = "Line 2"
        b.position = CGPoint(x: b.position.x, y: b.position.y - 20)
        a.text = st1
        b.text = st2
        parsed.addChild(a)
        parsed.addChild(b)
        parsed.position = CGPoint(x: self.size.width / 2, y: self.size.height / 1.5)
        return parsed
//        let randomThing = SKLabelNode(fontNamed: "Arial")
//        randomThing.fontSize = 25
//        randomThing.verticalAlignmentMode = .top
//        randomThing.position = CGPoint(x: self.size.width / 2, y: self.size.height / 1.5)
//        //randomThing.
//        randomThing.text = "Tdfsdfdf dfdf df d fdfdfd fddfd fdfd d  fd fd fouch to return"
//        return randomThing
    }
    
    func workWithScore(mScore: Int)->String{
        //seeing if this works...
        let url = URL(string: "http://www/numbersapi.com/" + String(mScore))
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                print(error!)
                return
            }
            guard let data = data else {
                print("Data is empty")
                return
            }
            let res = try! JSONSerialization.jsonObject(with: data, options: [])
            print(res)
        }
        task.resume()
        return "fuck"
    }
}

