//
//  GameScene.swift
//  IOS Pong
//
//  Created by DEVELOPER on 12/06/17.
//  Copyright © 2017 ROOT. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let 🤖 = SKSpriteNode(color: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), size: CGSize(width: 20, height: 80))
    let 🎮 = SKSpriteNode(color: #colorLiteral(red: 1, green: 0, blue: 0.04969102033, alpha: 1), size: CGSize(width: 20, height: 80))
    let 🏀 = SKShapeNode(circleOfRadius: 10)
    let category🎮: UInt32 = 0x1 << 0
    let category🏀: UInt32 = 0x1 << 1
    let 🏆 = SKLabelNode(fontNamed:"Chalkduster")
    var score : UInt32 = 0
    var velocity = 300
    var 💙 = 3;
    var vidas = [SKLabelNode]()
    
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        let edge = SKShapeNode()
        let edgePath = CGPath(rect: self.frame, transform: nil)
        edge.path = edgePath
        edge.strokeColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        edge.lineWidth = 1
        edge.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        edge.physicsBody?.friction = 0
        self.addChild(edge)
        
        
        for i in 1...💙 {
            vidas.append(drawVidas(CGPoint(x: 100 + 50*i, y: 700)))
            addChild(vidas[i-1])
        }
        
        🎮.position = CGPoint(x: 100, y: self.frame.midY)
        🎮.physicsBody = SKPhysicsBody(rectangleOf: 🎮.size)
        🎮.physicsBody?.contactTestBitMask = category🏀
        🎮.physicsBody?.categoryBitMask = category🎮
        🎮.physicsBody?.isDynamic = false
        self.addChild(🎮)

        🤖.position = CGPoint(x: 1234, y: self.frame.midY)
        🤖.physicsBody = SKPhysicsBody(rectangleOf: 🤖.size)
        🤖.physicsBody?.isDynamic = false
        🤖.physicsBody?.friction = 0
        self.addChild(🤖)
        
        🏀.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        🏀.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        🏀.physicsBody = SKPhysicsBody(circleOfRadius: 🏀.frame.width / 2)
        🏀.physicsBody?.contactTestBitMask = category🎮
        🏀.physicsBody?.categoryBitMask = category🏀
        🏀.physicsBody?.isDynamic = true
        🏀.physicsBody?.velocity = CGVector(dx: velocity, dy: velocity)
        🏀.physicsBody?.friction = 0
        🏀.physicsBody?.restitution = 1
        🏀.physicsBody?.linearDamping = 0
        self.addChild(🏀)
        
        self.🏆.fontSize = 50
        self.🏆.text = "Score: \(score)"
        self.🏆.color = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        self.🏆.position = CGPoint(x: 1100, y: 700)
        self.addChild(🏆)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
    }
    
   
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if collision == category🎮 | category🏀 {
            if let body = 🏀.physicsBody {
                if body.velocity.dx > 0 {
                    score += UInt32(body.velocity.dx)
                    body.velocity.dx += 100
                    
                }
            }
            
        }
    }
    
    func drawVidas(_ location: CGPoint) -> SKLabelNode
    {
        let vida = SKLabelNode(fontNamed: "Apple Color Emoji")
        vida.position = location
        vida.fontSize = 50
        vida.text = "💙"
        return vida
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            🎮.position.y = touch.location(in: self).y
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        🤖.position.y = 🏀.position.y;
        🏆.text = "Score: \(score)"
        
        if 🏀.position.x < 50 {
            🏀.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            🏀.physicsBody?.velocity = CGVector(dx: velocity, dy: velocity)
            💙 -= 1
            if vidas.count > 0 {
                vidas.last?.removeFromParent()
                vidas.removeLast()
            }
            if 💙 < 1 {
                let novaCena = GameOver(size:self.size)
                novaCena.scaleMode = scaleMode
                let reveal = SKTransition.crossFade(withDuration: 1.5)
                self.view?.presentScene(novaCena, transition: reveal)
            }
        }
    }
}
