import SpriteKit
import GameplayKit

class Scorer {
    private var highscoreLabel: SKLabelNode?
    private var scoreLabel: SKLabelNode?
    private let m_scene: GameScene
    private let userdefs = UserDefaults.standard
    private var score: Int = 0
    
    init(scene: GameScene) {
        m_scene = scene
        //create the scoring text first
        scoreLabel = SKLabelNode(fontNamed: "Arial")
        scoreLabel?.text = "Score: " + String(score)
        scoreLabel?.fontSize = 20
        scoreLabel?.verticalAlignmentMode = .top
        scoreLabel?.position = CGPoint(x: 60, y: m_scene.size.height - 10)
        m_scene.addChild(scoreLabel!)
        
        //highscore
        highscoreLabel = SKLabelNode(fontNamed: "Arial")
        highscoreLabel?.text = "HighScore: " + String(getHighScore())
        highscoreLabel?.fontSize = 20
        highscoreLabel?.verticalAlignmentMode = .top
        highscoreLabel?.position = CGPoint(x: m_scene.size.width - 80, y: m_scene.size.height - 10)
        m_scene.addChild(highscoreLabel!)
    }
    
    func incScore() {
        //increment the score by 1
        score += 1
        scoreLabel?.text = "Score: " + String(score)
        
        if (score > getHighScore()) {
            userdefs.set(score, forKey: "highScore")
            highscoreLabel?.text = "HighScore: " + String(score)
        }
    }
    
    func getCurrentScore()->Int{
        return score
    }
    
    func getHighScore () -> Int {
        if let highScore = userdefs.value(forKey: "highScore") {
            return highScore as! Int
        } else {
            userdefs.set(0, forKey: "highScore")
            return 0
        }
    }
}
