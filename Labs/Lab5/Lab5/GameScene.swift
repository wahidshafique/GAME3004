//
//  GameScene.swift
//  Lab5
//
//  Created by C410 on 2017-02-06.
//  Copyright © 2017 GBC. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let Player: UInt32 = 1
    static let Obstacle: UInt32 = 2
    static let Edge: UInt32 = 4
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var player : SKShapeNode?
    
    
    
    let cols = [SKColor.blue, SKColor.red, SKColor.yellow, SKColor.green]
    
    var playerColIdx = 0
    var playerSpeed = CGFloat(1)
    var beeAtlas : SKTextureAtlas?
    

    
    //Create a 1/4 of a circle using UIBezierPath
    func addCircle()->CGPath{
    
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x:0,y: -200))
        
        path.addLine(to: CGPoint(x:0,y: -160))
        
        path.addArc(withCenter: CGPoint.zero,
                    radius: 160,
                    startAngle: CGFloat(3.0*M_PI_2),
                    endAngle: CGFloat(0),
                    clockwise: true)
        
        path.addLine(to: CGPoint(x: 200, y: 0))
        
        path.addArc(withCenter: CGPoint.zero,
                        radius: 200,
                        startAngle: CGFloat(0),
                        endAngle: CGFloat(3.0*M_PI_2),
                        clockwise: false)
        
        return path.cgPath
        
    }
    //reaction to the collision of two physics bodies
    func didBegin(_ contact: SKPhysicsContact) {
        
        if let nodeA = contact.bodyA.node as? SKShapeNode, let nodeB = contact.bodyB.node as? SKShapeNode {
            if nodeA.fillColor != nodeB.fillColor {
                player?.physicsBody?.velocity = CGVector.zero
                player?.removeFromParent()
            }
        }
    }
    
    override func didSimulatePhysics() {
            player?.physicsBody?.velocity.dx = 0
        }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        beeAtlas = SKTextureAtlas(named: "bee.atlas")
        
        let bee = SKSpriteNode(texture: beeAtlas?.textureNamed("bee.png"))
        bee.run(SKAction.repeatForever(
            SKAction.animate(with: [(beeAtlas?.textureNamed("bee.png"))!,
            (beeAtlas?.textureNamed("bee_fly.png"))!],
            timePerFrame: 0.1)))
        
        bee.position = CGPoint(x: 10, y: 225)
        self.addChild(bee)
        
        //Template for our circle section
        self.spinnyNode = SKShapeNode(path: addCircle())
        
        let snBody = SKPhysicsBody(polygonFrom: addCircle())
        
        snBody.categoryBitMask = PhysicsCategory.Player
        snBody.collisionBitMask = PhysicsCategory.Edge | PhysicsCategory.Player
        
        snBody.affectedByGravity = false
        
        //circle
        let container = SKNode()

        var i = Double(0)
        //create sections in 4 colors
        for c in cols {
            let n = self.spinnyNode?.copy() as! SKShapeNode
            
            n.position = CGPoint.zero
            n.strokeColor = c
            n.fillColor = c
            n.zRotation = CGFloat(i*M_PI_2)
            n.physicsBody = snBody.copy() as! SKPhysicsBody
            container.addChild(n)
            i+=Double(1)
        }
        //make it spin
        container.run(
            SKAction.repeatForever(
                SKAction.rotate(byAngle: CGFloat(2),
                                duration: 0.5)
                )
            )
        
        self.addChild(container)
        addPlayer()
        
    }
    
    func addPlayer() {
        //add player node (ball)
        self.player = SKShapeNode(circleOfRadius: 40)
        self.player?.fillColor = cols[playerColIdx]
        self.player?.strokeColor = (self.player?.fillColor)!
        self.player?.position = CGPoint(
            x:0, y:-self.size.height/2 + 20)
        
        let pBody = SKPhysicsBody(circleOfRadius: 40)
        
        pBody.categoryBitMask = PhysicsCategory.Player
        pBody.collisionBitMask = PhysicsCategory.Edge
        
        pBody.contactTestBitMask = PhysicsCategory.Obstacle
        pBody.affectedByGravity = false
        player?.physicsBody = pBody
        
        self.addChild(player!)

    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        //change player color on touch
        playerColIdx = (playerColIdx+1)%cols.count
        self.player?.fillColor = cols[playerColIdx]
        
        //make it fly up
        player?.physicsBody?.velocity.dy = 800
    }
    
    func touchMoved(toPoint pos : CGPoint) {
       
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            label.run(SKAction.removeFromParent())
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

        //using position to move player
        //let p = player?.position
        
        //player?.position = CGPoint(x: p!.x, y: p!.y+playerSpeed)
    }

}
