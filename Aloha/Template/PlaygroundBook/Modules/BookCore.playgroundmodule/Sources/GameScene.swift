//
//  GameScene.swift
//  BookCore
//
//  Created by Anderson Alencar on 14/05/20.
//

import Foundation
import UIKit
import SpriteKit
import PlaygroundSupport
import CoreGraphics
import AVFoundation


public class GameScene: SKScene {
    
    public var sand = SKSpriteNode(imageNamed: "sand")
    public var sea = SKSpriteNode(imageNamed: "sea")
    public var intro = SKSpriteNode(imageNamed: "intro")
    public var player = SKSpriteNode(imageNamed: "player")
    public var velocity: Double = 250.0
    public var gameFinished = false
    public var gameStarted = false
    public var restart = false
    public var number1: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    public var number2: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    public var operation: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    public var equal: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    public var surfForce: CGFloat = 4000.0
    public var touching = false
    public var playerCategory: UInt32 = 1
    public var animalCategory: UInt32 = 2
    public var bubbleCategory: UInt32 = 4
    public var sandCategory: UInt32 = 8
    public var timerAnimal: Timer!
    public var timerBubble: Timer!
    public var bubble = SKSpriteNode()
    var indexBubble = 0
    public weak var gameController: GameSurfViewController?
    
    public var manager = ModelManager()
    
    public let bubbleSound = SKAction.playSoundFileNamed("bubble.mp3", waitForCompletion: false)
    public let gameOverSound = SKAction.playSoundFileNamed("gameOver.mp3", waitForCompletion: false)
    
    override public func didMove(to view: SKView){
        physicsWorld.contactDelegate = self
        self.backgroundColor = UIColor(red: 0.99, green: 0.87, blue: 0.78, alpha: 1.00)
        addSand()
        addSea()
        addIntro()
        addPlayer()
        moveSea()
    }

    public func addSand() {
        sand.position = CGPoint(x: self.size.width/2, y: sand.size.height/2)
        sand.zPosition = 0
        addChild(sand)
        
        let invisibleSand = SKNode()
        invisibleSand.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: 1))
        invisibleSand.physicsBody?.isDynamic = false
        invisibleSand.position = CGPoint(x: self.size.width/2, y: 4 * (sand.size.height/5))
        invisibleSand.zPosition = 2
        
        invisibleSand.physicsBody?.categoryBitMask = sandCategory
        invisibleSand.physicsBody?.contactTestBitMask = playerCategory
        invisibleSand.physicsBody?.collisionBitMask = playerCategory
        addChild(invisibleSand)
        
        let invisibleSky = SKNode()
        invisibleSky.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: 1))
        invisibleSky.physicsBody?.isDynamic = false
        invisibleSky.position = CGPoint(x: self.size.width/2, y: sand.size.height + 3 * (sea.size.height/4))
        invisibleSky.zPosition = 2
        
        

        addChild(invisibleSky)
    }
    
    public func addSea() {
        sea.position = CGPoint(x: sea.size.width/2, y: sand.size.height + sea.size.height/2)
        sea.zPosition = 1
        addChild(sea)
    }
    
    public func addIntro() {
        intro.position = CGPoint(x: self.size.width/2, y: sand.size.height + intro.size.height)
        intro.zPosition = 3
        let introAction = SKAction.fadeAlpha(to: 0.5, duration: 0.7)
        let introAction2 = SKAction.fadeAlpha(to: 1, duration: 0.7)
        let sequenceAction = SKAction.sequence([introAction, introAction2])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        intro.run(repeatAction)
        
        addChild(intro)
    }
    
    public func addPlayer() {
        player.position = CGPoint(x: sand.size.width/4, y: sand.size.height + sea.size.height/2)
        player.zPosition = 4
        addChild(player)
        
    }
    
    public func moveSea() {
        let duration = Double(sea.size.width/2)/velocity
        let moveSeaAction = SKAction.moveBy(x: -sea.size.width/2, y: 0, duration: duration)
        let resetXAction = SKAction.moveBy(x: sea.size.width/2, y: 0, duration: 0)
        let sequenceActions = SKAction.sequence([moveSeaAction,resetXAction])
        let repeatActions =  SKAction.repeatForever(sequenceActions)
        sea.run(repeatActions)
    }
    
    public func setScoreLabels() {
        number1.fontSize = 150
        number2.fontSize = 150
        operation.fontSize = 150
        
        number1.text = ""
        number2.text = ""
        operation.text = ""
        equal.text = ""

        number1.zPosition = 5
        number2.zPosition = 5
        operation.zPosition = 5
        
        number1.fontColor = .black
        number2.fontColor = .black
        operation.fontColor = .black

        number1.alpha = 0.8
        number2.alpha = 0.8
        operation.alpha = 0.8

        number1.position = CGPoint(x: sand.size.width/4, y: sand.size.height + sea.size.height - sea.size.height/5)
        number2.position = CGPoint(x: sand.size.width/4 + 200, y: sand.size.height + sea.size.height - sea.size.height/5)
        operation.position = CGPoint(x: sand.size.width/4 + 100, y: sand.size.height + sea.size.height - sea.size.height/5)
        
        addChild(number1)
        addChild(number2)
        addChild(operation)
    }
    
    public func setPlayerPhysicsBody() {
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width/2)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.allowsRotation = true
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: surfForce))
        
        player.physicsBody!.categoryBitMask = playerCategory
        player.physicsBody!.contactTestBitMask = animalCategory
        player.physicsBody!.collisionBitMask = animalCategory
    }
    
    public func generateMarineAnimal() {
        let base = Float(sand.size.height)
        let roof = Float(3 * (sea.size.height/4))
        let initialPosition = CGFloat(Float.random(in: base...roof))
        let animalIndex = Int.random(in: 1...3)
        
        let animal = SKSpriteNode(imageNamed: "animal\(animalIndex)")
        let animalWidth = animal.size.width
        //let animalHigth = animal.size.height
        
        animal.position = CGPoint(x: self.size.width + animalWidth/2, y: initialPosition)
        animal.zPosition = 3
        animal.physicsBody = SKPhysicsBody(circleOfRadius: animal.size.width/1000)
        animal.physicsBody?.isDynamic = false
        
        let distance = size.width + animalWidth
        let duration = Double(distance)/velocity
        let moveAction = SKAction.moveBy(x: -distance, y: 0, duration: duration)
        let removeAction = SKAction.removeFromParent()
        let sequenceAction = SKAction.sequence([moveAction,removeAction])
        
        animal.physicsBody?.categoryBitMask = animalCategory
        animal.physicsBody?.contactTestBitMask = playerCategory
        animal.physicsBody?.collisionBitMask = playerCategory
        
        animal.run(sequenceAction)
        addChild(animal)
    }
    
    public func generateBubbleNumber() {
        let base = Float(sand.size.height)
        let roof = Float(3 * (sea.size.height/4))
        let initialPosition = CGFloat(Float.random(in: base...roof))

        
        if manager.number1 != 0 && manager.operation == 0 {
            indexBubble = manager.getBubble()
            bubble = SKSpriteNode(imageNamed: "operation\(indexBubble)")
        } else {
            indexBubble = manager.getBubble()
            bubble = SKSpriteNode(imageNamed: "bubble\(indexBubble)")
            
        }
        
        
        let bubbleWidth = bubble.size.width
        //let bubbleHigth = bubble.size.height
        
        bubble.position = CGPoint(x: self.size.width + bubbleWidth/2, y: initialPosition)
        bubble.zPosition = 3
        bubble.physicsBody = SKPhysicsBody(circleOfRadius: bubble.size.width/1000)
        bubble.physicsBody?.isDynamic = false
        
        let distance = size.width + bubbleWidth
        let duration = Double(distance)/velocity
        let moveAction = SKAction.moveBy(x: -distance, y: 0, duration: duration)
        let removeAction = SKAction.removeFromParent()
        let sequenceAction = SKAction.sequence([moveAction,removeAction])
        
        bubble.physicsBody?.categoryBitMask = bubbleCategory
        bubble.physicsBody?.contactTestBitMask = playerCategory
        bubble.physicsBody?.collisionBitMask = playerCategory

        
        bubble.run(sequenceAction)
        addChild(bubble)

    }
    
    public func gameOver() {
        timerAnimal.invalidate()
        timerBubble.invalidate()
        player.zRotation = 0
        for node in self.children {
            node.removeAllActions()
        }
        player.physicsBody?.isDynamic = false
        gameFinished = true
        gameStarted = false
        
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            let gamerOverLabel = SKLabelNode(fontNamed: "Chalkduster")
            gamerOverLabel.fontColor = UIColor(red: 0.93, green: 0.45, blue: 0.00, alpha: 1.00)
            gamerOverLabel.fontSize = 60
            gamerOverLabel.text = "Oops you were almost there, try again!"
            gamerOverLabel.position = CGPoint(x: self.size.width/2, y: self.sand.size.height + self.sea.size.height/3)
            gamerOverLabel.zPosition = 5
            self.addChild(gamerOverLabel)
            self.restart = true
        }
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameFinished {
            if !gameStarted {
                intro.removeFromParent()
                setScoreLabels()
                player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width/2)
                player.physicsBody?.isDynamic = true
                player.physicsBody?.allowsRotation = true
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: surfForce))
                gameStarted = true
                timerAnimal = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (timer) in
                    self.generateMarineAnimal()
                }
                timerBubble = Timer.scheduledTimer(withTimeInterval: 7, repeats: true) { (timer) in
                    self.generateBubbleNumber()
                }
            } else {
                player.physicsBody?.velocity = CGVector.zero
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: surfForce))
            }
        } else {
            if restart {
                restart = false
                gameController?.presentScene()
            }
        }
    }
    
    override public func update(_ currentTime: TimeInterval) {
        if gameStarted {
            let yVelocity = player.physicsBody!.velocity.dy * 0.0005 as CGFloat
            let rotateAction = SKAction.rotate(toAngle: yVelocity, duration: 0.25, shortestUnitArc:true)
            player.run(rotateAction)
        }
    }
}


extension GameScene: SKPhysicsContactDelegate {
    
    public func didBegin(_ contact: SKPhysicsContact) {
        if gameStarted {
            if contact.bodyA.categoryBitMask == animalCategory || contact.bodyB.categoryBitMask == animalCategory {
                number1.text = "Animal"
            } else if contact.bodyA.categoryBitMask == bubbleCategory || contact.bodyB.categoryBitMask == bubbleCategory {
                number1.text = "bubble"
                bubble.removeFromParent()
                manager.touchBubble(index: indexBubble)
                run(bubbleSound)
            } else if contact.bodyA.categoryBitMask == sandCategory || contact.bodyB.categoryBitMask == sandCategory {
                number1.text = "sand"
                run(gameOverSound)
                gameOver()
                
                
            }
        }
    }
}

