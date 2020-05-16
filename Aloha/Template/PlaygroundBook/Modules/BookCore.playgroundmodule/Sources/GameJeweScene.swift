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
    public var player = SKSpriteNode(imageNamed: "player1")
    public var velocity: Double = 250.0
    public var playerCategory: UInt32 = 1
    public var jeweCategory: UInt32 = 2
    public var sandCategory: UInt32 = 4

    
    
    
    
    
    override public func didMove(to view: SKView){
        //physicsWorld.contactDelegate = self
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
    
}
