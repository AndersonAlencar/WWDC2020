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
    
    override func didMove(to view: SKView){
        self.backgroundColor = UIColor(red: 0.99, green: 0.87, blue: 0.78, alpha: 1.00)
        addSand()
        addSea()
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
