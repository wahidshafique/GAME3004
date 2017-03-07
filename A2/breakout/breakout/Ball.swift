import SpriteKit
import GameplayKit

class Ball {
    
    init(scene: GameScene, radius: CGFloat) {
        let ball = SKShapeNode(circleOfRadius: radius)
        ball.fillColor = SKColor.blue
        ball.position = CGPoint(x: scene.size.width/2, y: scene.size.height/2)
        scene.addChild(ball)
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius:radius)
        
        ball.physicsBody!.restitution = 1
        ball.physicsBody?.friction = 0
        ball.physicsBody?.linearDamping = 0;
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.applyImpulse(CGVector(dx: 0.1, dy: -radius / 2))
        
        //add the balls coll category here
        ball.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        ball.physicsBody?.collisionBitMask = PhysicsCategory.Paddle | PhysicsCategory.Brick
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.Bottom
    }
    
}
