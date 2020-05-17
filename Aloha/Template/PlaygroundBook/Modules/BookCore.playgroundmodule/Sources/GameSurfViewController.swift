//
//  GameSurfViewController.swift
//  BookCore
//
//  Created by Anderson Alencar on 14/05/20.
//

import Foundation
import UIKit
import AVFoundation
import SpriteKit

public class GameSurfViewController: UIViewController {
    
    public var stage: SKView!
    public var backgroundMusic: AVAudioPlayer!
    public var player: AVAudioPlayer?
    override public func viewDidLoad() {
        presentScene()
    }
    
    public func presentScene() {
        let view = SKView()
        view.ignoresSiblingOrder = true
        let scene = GameScene(size: CGSize(width: 1536, height: 2048))
        scene.gameController = self
        scene.scaleMode = SKSceneScaleMode.aspectFill
        view.presentScene(scene, transition: .doorsOpenVertical(withDuration: 0.5))
        playSound()
        self.view = view
    }

    public func playSound() {
        guard let url = Bundle.main.url(forResource: "music", withExtension: "m4a") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            
            player.volume = 0.03
            player.numberOfLoops = -1
            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    public func presentAnimal(name: String) {
        let controller = AnimalViewController()
        controller.animalName = name
        controller.modalPresentationStyle  = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
    
}
