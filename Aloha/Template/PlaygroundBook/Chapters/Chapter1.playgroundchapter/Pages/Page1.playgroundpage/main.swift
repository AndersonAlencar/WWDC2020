//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//#-end-hidden-code
import UIKit
import SpriteKit
import PlaygroundSupport
import CoreGraphics



class GameScene: SKScene {
    
    
    var sand = SKSpriteNode(imageNamed: "sand")
    var sea = SKSpriteNode(imageNamed: "sea")
    var intro = SKSpriteNode(imageNamed: "intro")
    var player = SKSpriteNode(imageNamed: "player")
    var velocity: Double = 250.0
    var gameFinished = false
    var gameStarted = false
    var restart = false
    var number1: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    var number2: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    var operation: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    var surfForce: CGFloat = 4000.0
    var touching = false
    
    override func didMove(to view: SKView){
        self.backgroundColor = UIColor(red: 0.99, green: 0.87, blue: 0.78, alpha: 1.00)
        addSand()
        addSea()
        addIntro()
        addPlayer()
        moveSea()
    }
    
    @objc func play(sender: UILongPressGestureRecognizer) {
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: surfForce))
    }
    

    func addSand() {
        sand.position = CGPoint(x: self.size.width/2, y: sand.size.height/2)
        sand.zPosition = 0
        addChild(sand)
    }
    
    func addSea() {
        sea.position = CGPoint(x: sea.size.width/2, y: sand.size.height + sea.size.height/2)
        sea.zPosition = 1
        addChild(sea)
    }
    
    func addIntro() {
        intro.position = CGPoint(x: self.size.width/2, y: sand.size.height + intro.size.height)
        intro.zPosition = 3
        addChild(intro)
    }
    
    func addPlayer() {
        player.position = CGPoint(x: sand.size.width/4, y: sand.size.height + sea.size.height/2)
        player.zPosition = 4
        addChild(player)
        
    }
    
    func moveSea() {
        let duration = Double(sea.size.width/2)/velocity
        let moveSeaAction = SKAction.moveBy(x: -sea.size.width/2, y: 0, duration: duration)
        let resetXAction = SKAction.moveBy(x: sea.size.width/2, y: 0, duration: 0)
        let sequenceActions = SKAction.sequence([moveSeaAction,resetXAction])
        let repeatActions =  SKAction.repeatForever(sequenceActions)
        sea.run(repeatActions)
    }
    
    func setScoreLabels() {
        number1.fontSize = 150
        number2.fontSize = 150
        operation.fontSize = 150
        
        number1.text = "1"
        number2.text = "2"
        operation.text = "+"

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
    
    func setPlayerPhysicsBody() {
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width/2)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.allowsRotation = true
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: surfForce))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameFinished {
            if !gameStarted {
                intro.removeFromParent()
                setScoreLabels()
                player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width/2)
                player.physicsBody?.isDynamic = true
                player.physicsBody?.allowsRotation = true
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: surfForce))
                gameStarted = true
            } else {
                player.physicsBody?.velocity = CGVector.zero
                player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: surfForce))
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if gameStarted {
            let yVelocity = player.physicsBody!.velocity.dy * 0.0005 as CGFloat
            let rotateAction = SKAction.rotate(toAngle: yVelocity, duration: 0.25, shortestUnitArc:true)
            player.run(rotateAction)
        }
    }
    
}




class GameSurfViewController: UIViewController {
    
    var stage: SKView!
    override func viewDidLoad() {
        presentScene()
    }
    
    func presentScene() {
        let view = SKView()
        view.ignoresSiblingOrder = true
        let scene = GameScene(size: CGSize(width: 1536, height: 2048))
        scene.scaleMode = SKSceneScaleMode.aspectFill
        view.presentScene(scene)
        self.view = view
    }
    
}

PlaygroundPage.current.liveView = GameSurfViewController()
