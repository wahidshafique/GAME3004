import SpriteKit
import GameplayKit

class Paddle {
    public var paddle: SKShapeNode
    private var width: Int
    init(scene: GameScene, sizeX: Int, sizeY: Int) {
        width = sizeX
        paddle = SKShapeNode(rectOf: CGSize(width: sizeX, height: sizeY))
        paddle.fillColor = SKColor.red
        paddle.position = CGPoint(x: scene.size.width/2, y: 20)
        
        scene.addChild(paddle)
        paddle.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sizeX, height: sizeY))
        paddle.physicsBody?.isDynamic = false
        paddle.physicsBody?.allowsRotation = false
        
        //add the balls coll category here
        paddle.physicsBody?.categoryBitMask = PhysicsCategory.Paddle
        paddle.physicsBody?.collisionBitMask = PhysicsCategory.Ball
        paddle.physicsBody?.contactTestBitMask = PhysicsCategory.None
    }
    
    func getWidth()->Int {
        return width
    }
}
