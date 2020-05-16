//
//  GameJeweScene.swift
//  BookCore
//
//  Created by Anderson Alencar on 15/05/20.
//

import UIKit
import SpriteKit
import PlaygroundSupport
import CoreGraphics
import AVFoundation


public class GameJeweScene: SKScene {
    
    
    public var sand = SKSpriteNode(imageNamed: "sand2")
    public var sea = SKSpriteNode(imageNamed: "sea")
    public var intro = SKSpriteNode(imageNamed: "intro2")
    public var player = SKSpriteNode(imageNamed: "player")
    public var velocity: Double = 250.0
    public var surfForce: CGFloat = 4000.0
    public var gameFinished = false
    public var gameStarted = false
    public var restart = false
    public var jewe1 = SKSpriteNode(imageNamed: "diamanteBase")
    public var jewe2 = SKSpriteNode(imageNamed: "rubyBase")
    public var jewe3 = SKSpriteNode(imageNamed: "esmeraldaBase")
    public var jeweOC1 = SKSpriteNode(imageNamed: "diamanteOC")
    public var jeweOC2 = SKSpriteNode(imageNamed: "rubyOC")
    public var jeweOC3 = SKSpriteNode(imageNamed: "esmeraldaOC")
    public var timerJewels: Timer!
    public var timerGuaranteeColor: Timer!
    public var playerCategory: UInt32 = 1
    public var diamondCategory: UInt32 = 2
    public var rubyCategory: UInt32 = 4
    public var emeraldCategory: UInt32 = 8
    public var sandCategory: UInt32 = 16
    public var jewelryOrder = [UInt32(2),UInt32(4),UInt32(8)]
    public var playerColors: Set = [2,1,3]
    public var guaranteeColor = [1,2]
    public var lives = 5
    public var hearts = [SKSpriteNode]()
    
    public let jewelSound = SKAction.playSoundFileNamed("bubble.mp3", waitForCompletion: false)
    public let gameOverSound = SKAction.playSoundFileNamed("gameOver.mp3", waitForCompletion: false)
    
    
    public weak var gameController: GameJewelViewController?
    
    override public func didMove(to view: SKView){
        physicsWorld.contactDelegate = self
        self.backgroundColor = UIColor(red: 0.99, green: 0.87, blue: 0.78, alpha: 1.00)
        addSand()
        addCastleJewe()
        addSea()
        addIntro()
        addPlayer()
        moveSea()
        loadHearts()
        addJewelsOC()
    }
    
    public func addJewelsOC() {
        jeweOC1.position = CGPoint(x: sand.size.width/8, y: 4*(sand.size.height/5))
        jeweOC1.zPosition = 4
        addChild(jeweOC1)
        
        jeweOC2.position = CGPoint(x: sand.size.width/8 + 250, y: 4*(sand.size.height/5))
        jeweOC2.zPosition = 4
        addChild(jeweOC2)
        
        jeweOC3.position = CGPoint(x: sand.size.width/8 + 500, y: 4*(sand.size.height/5))
        jeweOC3.zPosition = 4
        addChild(jeweOC3)
    }
    
    public func animateJewel(jewel: SKSpriteNode) {
        let introAction = SKAction.fadeAlpha(to: 0.5, duration: 0.7)
        let introAction2 = SKAction.fadeAlpha(to: 1, duration: 0.7)
        let sequenceAction = SKAction.sequence([introAction, introAction2])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        jewel.run(repeatAction)
    }
    
    public func loadHearts() {
        for multiplier in 1...5 {
            let heart = SKSpriteNode(imageNamed: "coracao")
            heart.zPosition = 5
            heart.position = CGPoint(x: CGFloat(multiplier) * (sand.size.width/8), y: sand.size.height + CGFloat(9)*(sea.size.height/10))
            hearts.append(heart)
            addChild(heart)
        }
    }
    
    public func addCastleJewe() {
        jewe1.position = CGPoint(x: sand.size.width/2 + sand.size.width/7.5, y: sand.size.height/5)
        jewe1.zPosition = 1
        addChild(jewe1)
        
        jewe2.position = CGPoint(x: sand.size.width/2 + 2*(sand.size.width/5), y: sand.size.height/5)
        jewe2.zPosition = 1
        addChild(jewe2)
        
        let height = ((sand.size.width/2 + sand.size.width/7.5) + (sand.size.width/2 + 2*(sand.size.width/5)))/2
        jewe3.position = CGPoint(x: height, y: 7*(sand.size.height/10))
        jewe3.zPosition = 1
        addChild(jewe3)
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
        player.name = "1" // MUDAR ISSO SDFJKWSDBF,SBDJF,SDF,BSKFBWKFWJFKERFEJRHGFKERHGKERGKJERHFK
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
    
    public func generateJewels() {
        
        let randomJeweIndex = Int.random(in: 1...3)
        let randomTypeJewe = Int.random(in: 1...3)
        let base = Float(sand.size.height)
        let roof = Float(3 * (sea.size.height/4))
        let initialPosition = CGFloat(Float.random(in: base...roof))
        
        var jewe = SKSpriteNode(imageNamed: "")
        
        switch randomTypeJewe {
        case 1:
            //diamante
            jewe = SKSpriteNode(imageNamed: "diamanteB\(randomJeweIndex)")
            let jeweWidth = jewe.size.width
            jewe.position = CGPoint(x: self.size.width + jeweWidth/2, y: initialPosition)
            jewe.zPosition = 3
            jewe.physicsBody = SKPhysicsBody(circleOfRadius: jewe.size.width/1000)
            jewe.physicsBody?.isDynamic = false
            jewe.physicsBody?.categoryBitMask = diamondCategory
            jewe.name = "\(randomJeweIndex)"
            let distance = size.width + jeweWidth
            let duration = Double(distance)/velocity
            let moveAction = SKAction.moveBy(x: -distance, y: 0, duration: duration)
            let removeAction = SKAction.removeFromParent()
            let sequenceAction = SKAction.sequence([moveAction,removeAction])
            
            jewe.physicsBody?.contactTestBitMask = playerCategory
            jewe.physicsBody?.collisionBitMask = playerCategory
            jewe.run(sequenceAction)
            addChild(jewe)
        case 2:
            //ruby
            jewe = SKSpriteNode(imageNamed: "rubyB\(randomJeweIndex)")
            let jeweWidth = jewe.size.width
            jewe.position = CGPoint(x: self.size.width + jeweWidth/2, y: initialPosition)
            jewe.zPosition = 3
            jewe.physicsBody = SKPhysicsBody(circleOfRadius: jewe.size.width/1000)
            jewe.physicsBody?.isDynamic = false
            jewe.physicsBody?.categoryBitMask = rubyCategory
            jewe.name = "\(randomJeweIndex)"
            let distance = size.width + jeweWidth
            let duration = Double(distance)/velocity
            let moveAction = SKAction.moveBy(x: -distance, y: 0, duration: duration)
            let removeAction = SKAction.removeFromParent()
            let sequenceAction = SKAction.sequence([moveAction,removeAction])
            
            jewe.physicsBody?.contactTestBitMask = playerCategory
            jewe.physicsBody?.collisionBitMask = playerCategory
            jewe.run(sequenceAction)
            addChild(jewe)
        default:
            //esmeralda
            jewe = SKSpriteNode(imageNamed: "esmeraldaB\(randomJeweIndex)")
            let jeweWidth = jewe.size.width
            jewe.position = CGPoint(x: self.size.width + jeweWidth/2, y: initialPosition)
            jewe.zPosition = 3
            jewe.physicsBody = SKPhysicsBody(circleOfRadius: jewe.size.width/1000)
            jewe.physicsBody?.isDynamic = false
            jewe.physicsBody?.categoryBitMask = emeraldCategory
            jewe.name = "\(randomJeweIndex)"
            let distance = size.width + jeweWidth
            let duration = Double(distance)/velocity
            let moveAction = SKAction.moveBy(x: -distance, y: 0, duration: duration)
            let removeAction = SKAction.removeFromParent()
            let sequenceAction = SKAction.sequence([moveAction,removeAction])
            
            jewe.physicsBody?.contactTestBitMask = playerCategory
            jewe.physicsBody?.collisionBitMask = playerCategory
            jewe.run(sequenceAction)
            addChild(jewe)
        }
        
    }
    
    public func generateGuaranteeColor() {
        let typeJewe = jewelryOrder.first!
        let base = Float(sand.size.height)
        let roof = Float(3 * (sea.size.height/4))
        let initialPosition = CGFloat(Float.random(in: base...roof))
        var jewe = SKSpriteNode(imageNamed: "")
        
        switch typeJewe {
        case UInt32(2):
            //diamante
            jewe = SKSpriteNode(imageNamed: "diamanteB\(player.name!)")
            let jeweWidth = jewe.size.width
            jewe.position = CGPoint(x: self.size.width + jeweWidth/2, y: initialPosition)
            jewe.zPosition = 3
            jewe.physicsBody = SKPhysicsBody(circleOfRadius: jewe.size.width/1000)
            jewe.physicsBody?.isDynamic = false
            jewe.physicsBody?.categoryBitMask = diamondCategory
            jewe.name = "\(player.name!)"
            let distance = size.width + jeweWidth
            let duration = Double(distance)/velocity
            let moveAction = SKAction.moveBy(x: -distance, y: 0, duration: duration)
            let removeAction = SKAction.removeFromParent()
            let sequenceAction = SKAction.sequence([moveAction,removeAction])
            
            jewe.physicsBody?.contactTestBitMask = playerCategory
            jewe.physicsBody?.collisionBitMask = playerCategory
            jewe.run(sequenceAction)
            addChild(jewe)
        case UInt32(4):
            //ruby
            jewe = SKSpriteNode(imageNamed: "rubyB\(player.name!)")
            let jeweWidth = jewe.size.width
            jewe.position = CGPoint(x: self.size.width + jeweWidth/2, y: initialPosition)
            jewe.zPosition = 3
            jewe.physicsBody = SKPhysicsBody(circleOfRadius: jewe.size.width/1000)
            jewe.physicsBody?.isDynamic = false
            jewe.physicsBody?.categoryBitMask = rubyCategory
            jewe.name = "\(player.name!)"
            let distance = size.width + jeweWidth
            let duration = Double(distance)/velocity
            let moveAction = SKAction.moveBy(x: -distance, y: 0, duration: duration)
            let removeAction = SKAction.removeFromParent()
            let sequenceAction = SKAction.sequence([moveAction,removeAction])
            
            jewe.physicsBody?.contactTestBitMask = playerCategory
            jewe.physicsBody?.collisionBitMask = playerCategory
            jewe.run(sequenceAction)
            addChild(jewe)
        default:
            //esmeralda
            jewe = SKSpriteNode(imageNamed: "esmeraldaB\(player.name!)")
            let jeweWidth = jewe.size.width
            jewe.position = CGPoint(x: self.size.width + jeweWidth/2, y: initialPosition)
            jewe.zPosition = 3
            jewe.physicsBody = SKPhysicsBody(circleOfRadius: jewe.size.width/1000)
            jewe.physicsBody?.isDynamic = false
            jewe.physicsBody?.categoryBitMask = emeraldCategory
            jewe.name = "\(player.name!)"
            let distance = size.width + jeweWidth
            let duration = Double(distance)/velocity
            let moveAction = SKAction.moveBy(x: -distance, y: 0, duration: duration)
            let removeAction = SKAction.removeFromParent()
            let sequenceAction = SKAction.sequence([moveAction,removeAction])
            
            jewe.physicsBody?.contactTestBitMask = playerCategory
            jewe.physicsBody?.collisionBitMask = playerCategory
            jewe.run(sequenceAction)
            addChild(jewe)
        }
    }
    
    public func checkValidCategory(category: UInt32) -> Bool {
        if category == jewelryOrder.first! {
            return true
        }
        return false
    }
    
    public func matchName(player: String, jewe: String) -> Bool {
        if player == jewe {
            return true
        }
        return false
    }
    
    public func updateCastle(category: UInt32, name: String) {
        let category = jewelryOrder.removeFirst()
        switch category {
        case UInt32(2):
            jewe1.texture = SKTexture(imageNamed: "diamante\(name)")
        case UInt32(4):
            jewe2.texture = SKTexture(imageNamed: "ruby\(name)")
        default:
            jewe3.texture = SKTexture(imageNamed: "esmeralda\(name)")
        }
    }

    
    public func gameOver() {
        timerJewels.invalidate()
        timerGuaranteeColor.invalidate()
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
    
    public func alertWrongJewel() {
        run(gameOverSound)
        lives -= 1
        for (index, heart) in hearts.enumerated() {
            if index+1 > lives {
                heart.texture = SKTexture(imageNamed: "coracao1")
            }
        }
        if lives == 0 {
            gameOver()
        }
    }
    
    public func changePlayerColor() {
        let color = playerColors.removeFirst()
        player.texture = SKTexture(imageNamed: "player\(color)")
        player.name = String(color)
    }
    
    public func win() {
        timerGuaranteeColor.invalidate()
        timerJewels.invalidate()
        player.zRotation = 0
        for node in self.children {
            node.removeAllActions()
        }
        player.physicsBody?.isDynamic = false
        gameFinished = true
        gameStarted = false
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            let winLabel = SKLabelNode(fontNamed: "Chalkduster")
            winLabel.fontColor = UIColor(red: 0.93, green: 0.45, blue: 0.00, alpha: 1.00)
            winLabel.fontSize = 90
            winLabel.text = "Congratulations! You Win !"
            winLabel.position = CGPoint(x: self.size.width/2, y: self.sand.size.height + self.sea.size.height/3)
            winLabel.zPosition = 5
            self.addChild(winLabel)
            self.restart = true
        }
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameFinished {
            if !gameStarted {
                intro.removeFromParent()
                changePlayerColor()
                player.physicsBody?.categoryBitMask = playerCategory
                player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width/2)
                player.physicsBody?.isDynamic = true
                player.physicsBody?.allowsRotation = true
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: surfForce))
                gameStarted = true
                timerJewels = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (timer) in
                    self.generateJewels()
                }
                timerGuaranteeColor = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { (timer) in
                    self.generateGuaranteeColor()
                }
                animateJewel(jewel: jeweOC1)
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
    
    public override func update(_ currentTime: TimeInterval) {
        if gameStarted {
            let yVelocity = player.physicsBody!.velocity.dy * 0.0005 as CGFloat
            let rotateAction = SKAction.rotate(toAngle: yVelocity, duration: 0.25, shortestUnitArc:true)
            player.run(rotateAction)
        }
    }
    
}

extension  GameJeweScene: SKPhysicsContactDelegate {
    
    public func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == sandCategory || contact.bodyB.categoryBitMask == sandCategory {
            run(gameOverSound)
            gameOver()
        }
        else if contact.bodyA.categoryBitMask == diamondCategory || contact.bodyB.categoryBitMask == diamondCategory {
            var colisionJewel = SKNode()
            var player = SKNode()
            if (contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask) {
                colisionJewel = contact.bodyB.node!;
                player = contact.bodyA.node!;

            } else {
                colisionJewel = contact.bodyA.node!;
                player = contact.bodyB.node!;

            }
            
            if checkValidCategory(category: diamondCategory) {
                if matchName(player: player.name!, jewe: colisionJewel.name!) {
                    updateCastle(category: diamondCategory, name: colisionJewel.name!)
                    changePlayerColor()
                    run(jewelSound)
                    colisionJewel.removeFromParent()
                    jeweOC1.removeAllActions()
                    jeweOC1.texture = SKTexture(imageNamed: "diamanteB\(colisionJewel.name!)")
                    jeweOC1.alpha = 1
                    animateJewel(jewel: jeweOC2)
                } else {
                    alertWrongJewel()
                    colisionJewel.removeFromParent()
                }
                
            } else {
                alertWrongJewel()
                colisionJewel.removeFromParent()
            }
            
        }
        else if contact.bodyA.categoryBitMask == rubyCategory || contact.bodyB.categoryBitMask == rubyCategory {
            var colisionJewel = SKNode()
            var player = SKNode()
            if (contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask) {
                colisionJewel = contact.bodyB.node!;
                player = contact.bodyA.node!;

            } else {
                colisionJewel = contact.bodyA.node!;
                player = contact.bodyB.node!;

            }

            if checkValidCategory(category: rubyCategory) {
                if matchName(player: player.name!, jewe: colisionJewel.name!) {
                    updateCastle(category: rubyCategory, name: colisionJewel.name!)
                    changePlayerColor()
                    colisionJewel.removeFromParent()
                    run(jewelSound)
                    jeweOC2.removeAllActions()
                    jeweOC2.texture = SKTexture(imageNamed: "rubyB\(colisionJewel.name!)")
                    jeweOC2.alpha = 1
                    animateJewel(jewel: jeweOC3)
                } else {
                    alertWrongJewel()
                    colisionJewel.removeFromParent()
                }
                
            } else {
                alertWrongJewel()
                colisionJewel.removeFromParent()
            }
        }

        else if contact.bodyA.categoryBitMask == emeraldCategory || contact.bodyB.categoryBitMask == emeraldCategory {
            var colisionJewel = SKNode()
            var player = SKNode()
            if (contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask) {
                colisionJewel = contact.bodyB.node!;
                player = contact.bodyA.node!;

            } else {
                colisionJewel = contact.bodyA.node!;
                player = contact.bodyB.node!;

            }
            
            if checkValidCategory(category: emeraldCategory) {
                if matchName(player: player.name!, jewe: colisionJewel.name!) {
                    //updateCastle(category: emeraldCategory, name: colisionJewel.name!)
                    jewe3.texture = SKTexture(imageNamed: "esmeralda\(colisionJewel.name!)")
                    colisionJewel.removeFromParent()
                    run(jewelSound)
                    jeweOC3.removeAllActions()
                    jeweOC3.texture = SKTexture(imageNamed: "esmeraldaB\(colisionJewel.name!)")
                    jeweOC3.alpha = 1
                    win()
                } else {
                    alertWrongJewel()
                    colisionJewel.removeFromParent()
                }
            } else {
                alertWrongJewel()
                colisionJewel.removeFromParent()
            }
        }
        
    }
    
}
