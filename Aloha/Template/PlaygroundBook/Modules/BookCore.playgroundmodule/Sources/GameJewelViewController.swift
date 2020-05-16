//
//  GameJewelViewController.swift
//  BookCore
//
//  Created by Anderson Alencar on 15/05/20.
//

import Foundation
import UIKit
import SpriteKit

public class GameJewelViewController: UIViewController {
    
    public override func viewDidLoad() {
        presentScene()
    }
    
    
    public func presentScene() {
        let view = SKView()
        view.ignoresSiblingOrder = true
        let scene = GameJeweScene(size: CGSize(width: 1536, height: 2048))
        scene.gameController = self
        scene.scaleMode = SKSceneScaleMode.aspectFill
        view.presentScene(scene, transition: .doorsOpenVertical(withDuration: 0.5))
        self.view = view
    }
}
