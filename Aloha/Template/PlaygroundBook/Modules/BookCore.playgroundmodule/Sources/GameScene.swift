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
    public var response = false
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
    
    public func addFriends() {
        let introAction = SKAction.fadeAlpha(to: 0.5, duration: 0.7)
        let introAction2 = SKAction.fadeAlpha(to: 1, duration: 0.7)
        let sequenceAction = SKAction.sequence([introAction, introAction2])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        
        let friend1 = SKSpriteNode(imageNamed: "polvoB")//mudar sprite
        let friend2 = SKSpriteNode(imageNamed: "lulaB")//mudar sprite
        let friend3 = SKSpriteNode(imageNamed: "peixeLeaoB")//mudar sprite
        let friend4 = SKSpriteNode(imageNamed: "caranguejoB")//mudar sprite
        
        friend1.position = CGPoint(x: sand.size.width/8, y: sand.size.height/2)
        friend2.position = CGPoint(x: 3*(sand.size.width/8), y: sand.size.height/2)
        friend3.position = CGPoint(x: 5*(sand.size.width/8), y: sand.size.height/2)
        friend4.position = CGPoint(x: 7*(sand.size.width/8), y: sand.size.height/2)

        
        friend1.name = "polvo"
        friend2.name = "lula"
        friend3.name = "peixeLeao"
        friend4.name = "caranguejo"

        friend1.isUserInteractionEnabled = false
        friend2.isUserInteractionEnabled = false
        friend3.isUserInteractionEnabled = false
        
        friend1.zPosition = 5
        friend2.zPosition = 5
        friend3.zPosition = 5
        friend4.zPosition = 5
        
        friend1.run(repeatAction)
        friend2.run(repeatAction)
        friend3.run(repeatAction)
        friend4.run(repeatAction)

        
        addChild(friend1)
        addChild(friend2)
        addChild(friend3)
        addChild(friend4)

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
        equal.fontSize = 150

        number1.zPosition = 5
        number2.zPosition = 5
        operation.zPosition = 5
        equal.zPosition = 5
        
        number1.fontColor = .black
        number2.fontColor = .black
        operation.fontColor = .black
        equal.fontColor = .black

        number1.alpha = 0.8
        number2.alpha = 0.8
        operation.alpha = 0.8
        equal.alpha = 0.8

        number1.position = CGPoint(x: sand.size.width/2 - 150, y: sand.size.height + sea.size.height - sea.size.height/5)
        number2.position = CGPoint(x: sand.size.width/2 + 150, y: sand.size.height + sea.size.height - sea.size.height/5)
        operation.position = CGPoint(x: sand.size.width/2, y: sand.size.height + sea.size.height - sea.size.height/5)
        equal.position = CGPoint(x: sand.size.width/2 + 300, y: sand.size.height + sea.size.height - sea.size.height/5)
        
        addChild(number1)
        addChild(number2)
        addChild(operation)
        addChild(equal)
    }
    
    public func updateScoreLabels(number: Int) -> Bool{
        if manager.number1 == 0{
            number1.text = String(number)
        } else if manager.number2 == 0 && manager.operation == 0 {
            switch number {
            case 1:
                operation.text = "+"
            default:
                operation.text = "-"
            }
        } else {
            number2.text = String(number)
            equal.text = "="
            return true
        }
        return false
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
    
    public func win() {
        player.zRotation = 0
        for node in self.children {
            node.removeAllActions()
        }
        player.physicsBody?.isDynamic = false
        gameFinished = true
        gameStarted = false
        
        addFriends()
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
//            let winLabel = SKLabelNode(fontNamed: "Chalkduster")
//            winLabel.fontColor = UIColor(red: 0.93, green: 0.45, blue: 0.00, alpha: 1.00)
//            winLabel.fontSize = 90
//            winLabel.text = "Congratulations! You Win !"
//            winLabel.position = CGPoint(x: self.size.width/2, y: self.sand.size.height + self.sea.size.height/3)
//            winLabel.zPosition = 5
//            self.addChild(winLabel)
//            self.restart = true
//        }
    }
    
    public func hitAnimal() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            let hitLabel = SKLabelNode(fontNamed: "Chalkduster")
            hitLabel.fontColor = UIColor(red: 0.93, green: 0.45, blue: 0.00, alpha: 1.00)
            hitLabel.fontSize = 60
            hitLabel.text = "Oops! Don't run over marine animals!"
            hitLabel.position = CGPoint(x: self.size.width/2, y: self.sand.size.height/2)
            hitLabel.zPosition = 5
            hitLabel.alpha = 0
            
            let introAction = SKAction.fadeAlpha(to: 1, duration: 1)
            let introAction2 = SKAction.fadeAlpha(to: 0, duration: 3)
            let sequenceAction = SKAction.sequence([introAction, introAction2])
            hitLabel.run(sequenceAction)
            self.addChild(hitLabel)
        }
    }
    
    public func chooseAnswer() {
        var responses = Set<Int>()
        var responseBubble1 = SKSpriteNode()
        var responseBubble2 = SKSpriteNode()
        
        var nameResponse = 0
        
        switch manager.operation {
        case 1:
            responses.insert(manager.number1 + manager.number2)
        default:
            responses.insert(manager.number1 - manager.number2)
        }
        
        while responses.count < 2 {
            responses.insert(Int.random(in: 1...18))
        }
        
        nameResponse = responses.removeFirst()
        responseBubble1 = SKSpriteNode(imageNamed: "bubble\(nameResponse)")
        responseBubble1.name = String(nameResponse)
        nameResponse = responses.removeFirst()
        responseBubble2 = SKSpriteNode(imageNamed: "bubble\(nameResponse)")
        responseBubble2.name = String(nameResponse)
        
        
        responseBubble1.position = CGPoint(x: self.size.width + responseBubble1.size.width/2, y: sand.size.height + sea.size.height/6)
        responseBubble1.zPosition = 3
        responseBubble1.physicsBody = SKPhysicsBody(circleOfRadius: responseBubble1.size.width/3000)
        responseBubble1.physicsBody?.isDynamic = false
        responseBubble1.physicsBody?.categoryBitMask = bubbleCategory
        responseBubble1.physicsBody?.contactTestBitMask = playerCategory
        responseBubble1.physicsBody?.collisionBitMask = playerCategory
        
        responseBubble2.position = CGPoint(x: self.size.width + responseBubble1.size.width/2, y: sand.size.height + 5*(sea.size.height/8))
        responseBubble2.zPosition = 3
        responseBubble2.physicsBody = SKPhysicsBody(circleOfRadius: responseBubble1.size.width/3000)
        responseBubble2.physicsBody?.isDynamic = false
        responseBubble2.physicsBody?.categoryBitMask = bubbleCategory
        responseBubble2.physicsBody?.contactTestBitMask = playerCategory
        responseBubble2.physicsBody?.collisionBitMask = playerCategory
        
        let distance = size.width + responseBubble1.size.width
        let duration = Double(distance)/velocity
        let moveAction = SKAction.moveBy(x: -distance, y: 0, duration: duration)
        let removeAction = SKAction.removeFromParent()
        let sequenceAction = SKAction.sequence([moveAction,removeAction])
        
        response = true
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { (timer) in
            responseBubble1.run(sequenceAction)
            responseBubble2.run(sequenceAction)
            
            self.addChild(responseBubble1)
            self.addChild(responseBubble2)
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
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let node = self.atPoint(t.location(in :self))
            if  node.name == "caranguejo" {
                node.alpha = 0.3
            } else if  node.name == "lula" {
                node.alpha = 0.3
            } else if node.name == "peixeLeao" {
                node.alpha = 0.3
            } else if node.name == "polvo" {
                node.alpha = 0.3
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
                hitAnimal()
            } else if contact.bodyA.categoryBitMask == bubbleCategory || contact.bodyB.categoryBitMask == bubbleCategory {
                if response {
                    var bubbleBody = SKPhysicsBody()

                    if (contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask) {
                        bubbleBody = contact.bodyB;
                    } else {
                        bubbleBody = contact.bodyA;
                    }

                    let bubbleElement = bubbleBody.node!
                    switch manager.operation {
                    case 1:
                        if bubbleElement.name == String(manager.number1 + manager.number2) {
                            bubbleElement.removeFromParent()
                            run(bubbleSound)
                            win()
                        } else {
                            bubbleElement.removeFromParent()
                            run(gameOverSound)
                            gameOver()
                        }
                    default:
                        if bubbleElement.name == String(manager.number1 - manager.number2) {
                            run(bubbleSound)
                            win()
                        } else {
                            bubbleElement.removeFromParent()
                            run(gameOverSound)
                            gameOver()
                        }
                    }
                    
                } else {
                    bubble.removeFromParent()
                    let needResponse = updateScoreLabels(number: indexBubble) // Muito importante que isso seja antes
                    manager.touchBubble(index: indexBubble)
                    if needResponse {
                        timerAnimal.invalidate()
                        timerBubble.invalidate()
                        chooseAnswer()
                    }
                    run(bubbleSound)
                }
            } else if contact.bodyA.categoryBitMask == sandCategory || contact.bodyB.categoryBitMask == sandCategory {
                run(gameOverSound)
                gameOver()
                
                
            }
        }
    }
}

