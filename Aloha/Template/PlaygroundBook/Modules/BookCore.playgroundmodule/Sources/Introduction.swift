//
//  Introduction.swift
//  BookCore
//
//  Created by Anderson Alencar on 17/05/20.
//

import Foundation
import UIKit
import SpriteKit
import AVFoundation

public class Introduction: SKScene {
    
    
    
    var imageBackground = SKSpriteNode(imageNamed: "logoIntroduction")

    override public func didMove(to view: SKView) {
        setUpImageBackground()
        let utterance = AVSpeechUtterance(string: "Hello, my name is Anderson and for the past few months I have been experiencing social isolation. Millions of people needed to stay at home and we get discouraged without being able to do activities that we love and that inspire us. Can you imagine what it's like to be without doing what inspires you for a long time? This challenge is much greater for autistic children. The interruption of sections with psychologists and occupational therapies can make them very anxious, stressed and even aggressive, with difficulty in resocialization. It is very important activities to work on their motor coordination and cognition, so that they do not regress in their mental state. Thinking about what I love to do most, being with my family and surfing, I prepared activities to entertain and inspire all children, especially autistic children, so that they can always do what they love, even when they are away")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.3
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    public func setUpImageBackground() {
        imageBackground.position = CGPoint(x: (self.view?.scene?.size.width)!/2, y: (self.view?.scene?.size.height)!/2)
        
                
        addChild(imageBackground)
    }
}
