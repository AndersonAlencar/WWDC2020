//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//#-end-hidden-code
import UIKit
import PlaygroundSupport
import SpriteKit
//: Apenas testando


class GameScene: SKScene {
    override func didMove(to view: SKView){
        self.backgroundColor = .orange
    }
}


class Game: UIViewController {

    override func viewDidLoad(){
        super.viewDidLoad()
        setup()
    }
    func setup() {
        let view = SKView()
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        view.presentScene(scene)
        self.view = view
    }
}

PlaygroundPage.current.liveView = Game()

