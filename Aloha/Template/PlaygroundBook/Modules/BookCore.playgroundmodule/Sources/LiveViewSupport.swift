//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import SpriteKit
import PlaygroundSupport

/// Instantiates a new instance of a live view.
///
/// By default, this loads an instance of `LiveViewController` from `LiveView.storyboard`.
public func introductionLiveView() -> PlaygroundLiveViewable {
    let view = SKView()
    let scene  = Introduction(size: CGSize(width: 1536, height: 2048))
    scene.scaleMode = SKSceneScaleMode.aspectFill
    view.presentScene(scene)
    return view
}
