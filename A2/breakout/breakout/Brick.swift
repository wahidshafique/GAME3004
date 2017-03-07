import SpriteKit
import GameplayKit

class Brick {
    let brick: SKShapeNode
    init(scene: GameScene, posX: Int, posY: Int, sizeX: Int, sizeY: Int) {
        brick = SKShapeNode(rectOf: CGSize(width: sizeX, height: sizeY))
        brick.fillColor = getRandomColor()
        brick.position = CGPoint(x: posX, y: posY)
        
        scene.addChild(brick)
        brick.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sizeX, height: sizeY))
        brick.physicsBody?.isDynamic = false
        brick.physicsBody?.allowsRotation = false
        
        //add the balls coll category here
        //it touches the ball and interacts with it
        brick.physicsBody?.categoryBitMask = PhysicsCategory.Brick
        brick.physicsBody?.collisionBitMask = PhysicsCategory.Ball
        brick.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
    }
    
    func hasParent() ->Bool {
        return (brick.parent != nil)
    }
}
func getRandomColor() -> UIColor {
    let randomRed:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
    let randomGreen:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
    let randomBlue:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
    return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
}
