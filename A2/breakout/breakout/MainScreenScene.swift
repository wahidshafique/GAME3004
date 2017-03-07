import SpriteKit
import GameplayKit

class MainSceneScreen: SKScene {
    override init (size: CGSize) {
        super.init(size:size)
        
        //make the welcome text
        let welcome = SKLabelNode(fontNamed: "Arial")
        welcome.fontSize = 35
        welcome.verticalAlignmentMode = .top
        welcome.position = CGPoint(x: self.size.width / 2, y: self.size.height / 1.5)
        welcome.text = "Lets play BreakOut™!"
        self.addChild(welcome)
    }
    
    required init? (coder decoder:NSCoder) {
        super.init(coder: decoder)
    }
    
    override func touchesBegan (_ touches: Set<UITouch>, with event: UIEvent?) {
        let gameScene = GameScene(size: self.size)
        self.view?.presentScene(gameScene)
    }
}

