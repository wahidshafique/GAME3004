//
//  GameScene.swift
//  breakout
//
//  Created by Tech on 2017-03-05.
//  Copyright © 2017 Tech. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let Ball: UInt32 = 0b1
    static let Paddle: UInt32 = 0b10
    static let Brick: UInt32 = 0b100
    static let Bottom: UInt32 = 0b1000
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var scorerMan : Scorer?
    private var bricks : [Brick] = []
    private let paddleSpeed = CGFloat(15)
    private var label : SKLabelNode?
    private var playPaddle : Paddle?
    
    override init (size: CGSize) {
        super.init(size: size)
    }
    
    required init? (coder decoder:NSCoder) {
        super.init(coder: decoder)
    }
    
    override func didMove(to view: SKView) {
        //make basic UI
        scorerMan = Scorer(scene: self)
        
        //make the entities
        self.physicsWorld.contactDelegate = self
        let playBall = Ball(scene: self, radius: 10)
        playPaddle = Paddle(scene: self, sizeX: 60, sizeY: 25)
        makeBrickGrid(cols: 1, rows: 1)
        worldStuff()
    }
    
    func worldStuff(){
        //add some of the components for the world
        //add the border walls
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        
        //add the special deadzone (lose condition
        let deadZone = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: 1)
        let bottomEdge = SKNode()
        bottomEdge.physicsBody = SKPhysicsBody(edgeLoopFrom: deadZone)
        self.addChild(bottomEdge)
        //add the collisions
        bottomEdge.physicsBody?.categoryBitMask = PhysicsCategory.Bottom
        bottomEdge.physicsBody?.collisionBitMask = PhysicsCategory.Ball
        bottomEdge.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
        
        //finally make sure there is 0 g
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    }
    
    func makeBrickGrid (cols: Int, rows: Int) {
        //let widthLine = self.frame.size.width
        //Int(widthLine) / numofBricks
        let brickWidth = 30
        let pad:Float = 10
        let offs:Float = (Float(self.frame.size.width) - (Float(brickWidth) * Float(rows) + pad * (Float(rows) - 1))) / 2
        print("frame hgih is: %i", Int(self.frame.size.height))
        for i in 1...cols {
            for j in 1...rows {
                let c1:Float = Float(i) - 0.5
                let c2:Float = Float(i) - 1
                let resolve = CGFloat(c1 * Float(brickWidth) + c2 * pad + offs)
                bricks.append(Brick(scene: self, posX: Int(resolve), posY: j * 20 + Int(self.frame.size.height / 1.5), sizeX: brickWidth, sizeY: brickWidth / 2))
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //for all collision based events
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        //this is the lose condition
        if collision == PhysicsCategory.Ball | PhysicsCategory.Bottom {
            //game over! you get one chance :) 😄
            print("contact between ball and bottom")
            let gameoverScene = GameOverScene(size: self.frame.size, didYouWin: false)
            self.view?.presentScene(gameoverScene)
        }
        if collision == PhysicsCategory.Ball | PhysicsCategory.Brick {
            print("contact between ball and brick")
            contact.bodyA.node?.removeFromParent()
            //from from the array
            for i in stride(from: bricks.count - 1, to: 0, by: -1) {
                if bricks[i].hasParent() {
                } else {
                    bricks.remove(at: i)
                }
            }
            scorerMan?.incScore()
            print(bricks.count)
            if bricks.count <= 1 {
                print("empty")
                let gameWinScene = GameOverScene(size: self.frame.size, didYouWin: true)
                self.view?.presentScene(gameWinScene)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchCurr = touch?.location(in: self)
        let touchPrev = touch?.previousLocation(in: self)
        let p_width = playPaddle?.getWidth()
        
        let posLatest = (playPaddle?.paddle.position.x)! + ((touchCurr?.x)! - (touchPrev?.x)!)
        let clamped = min(max(posLatest, CGFloat(0 + p_width! / 2)), (scene?.size.width)! - CGFloat(p_width! / 2))
        
        playPaddle?.paddle.position = CGPoint(x: clamped, y: (playPaddle?.paddle.position.y)!)
        
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {

    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos: CGPoint) {
        
    }
    
    func touchUp(atPoint pos: CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
}

