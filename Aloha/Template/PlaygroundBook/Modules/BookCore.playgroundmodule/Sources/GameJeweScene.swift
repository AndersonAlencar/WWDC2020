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
    public var jewe1 = SKSpriteNode(imageNamed: "diamanteBase")
    public var jewe2 = SKSpriteNode(imageNamed: "rubyBase")
    public var jewe3 = SKSpriteNode(imageNamed: "esmeraldaBase")
    public var playerCategory: UInt32 = 1
    public var diamondCategory: UInt32 = 2
    public var rubyCategory: UInt32 = 4
    public var emeraldCategory: UInt32 = 8
    public var sandCategory: UInt32 = 16
    public var jewelryOrder = [UInt32(2),UInt32(4),UInt32(8)]
    public var playerColors: Set = [2,1,3]

    
    public var labelDebug = SKLabelNode()
    
    
    
    
    override public func didMove(to view: SKView){
        physicsWorld.contactDelegate = self
        self.backgroundColor = UIColor(red: 0.99, green: 0.87, blue: 0.78, alpha: 1.00)
        addSand()
        addCastleJewe()
        addSea()
        addIntro()
        addPlayer()
        moveSea()
        
        labelDebug.position = CGPoint(x: sand.size.width/2, y: sand.size.height/2)
        labelDebug.text = "Esperando..."
        labelDebug.fontColor = .black
        labelDebug.fontSize = 40
        labelDebug.zPosition = 1
        addChild(labelDebug)
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
        
        let randomJeweIndex = Int.random(in: 1...3) //responsável pela cor
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
    
    public func checkValidCategory(category: UInt32) -> Bool {
        //fazer um isEmpty return falso
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
        //esperando
        labelDebug.text = "gameover..."
    }
    
    public func alertWrongJewel() {
        //criar alerta na na areia, tentar reproduzir som
    }
    
    public func changePlayerColor() {
        let color = playerColors.removeFirst()
        player.texture = SKTexture(imageNamed: "player\(color)")
        player.name = String(color)
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
                Timer.scheduledTimer(withTimeInterval: 7, repeats: true) { (timer) in
                    self.generateJewels()
                }
            } else {
                player.physicsBody?.velocity = CGVector.zero
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: surfForce))
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
            //run(gameooversoound)
            gameOver()
        }
        else if contact.bodyA.categoryBitMask == diamondCategory || contact.bodyB.categoryBitMask == diamondCategory {
            labelDebug.text = "t1"
            if checkValidCategory(category: diamondCategory) {
                labelDebug.text = "t2"
                var colisionJewel = SKNode()
                var player = SKNode()
                if (contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask) {
                    colisionJewel = contact.bodyB.node!;
                    player = contact.bodyA.node!;

                } else {
                    colisionJewel = contact.bodyA.node!;
                    player = contact.bodyB.node!;

                }
                
                if matchName(player: player.name!, jewe: colisionJewel.name!) {
                    updateCastle(category: diamondCategory, name: colisionJewel.name!)
                    changePlayerColor()
                }
                
            }
            alertWrongJewel()
        }
    }
    
}
