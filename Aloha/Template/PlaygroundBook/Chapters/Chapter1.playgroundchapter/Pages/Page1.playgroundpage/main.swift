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




class GameScene: SKScene {
    
    
    var sand = SKSpriteNode(imageNamed: "sand")
    var sea = SKSpriteNode(imageNamed: "sea")
    var intro = SKSpriteNode(imageNamed: "intro")
    var player = SKSpriteNode(imageNamed: "player")
    var velocity: Double = 250.0
    
    override func didMove(to view: SKView){
        self.backgroundColor = UIColor(red: 0.99, green: 0.87, blue: 0.78, alpha: 1.00)
        addSand()
        addSea()
        addIntro()
        addPlayer()
        moveSea()
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
