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
import AVFoundation


class HelloPurple: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .red
        let utterance = AVSpeechUtterance(string: "Hello, my name is Anderson and I know how difficult it can be to stay at home in this period of isolation. How about having a little fun on the beach with my sister surfing with you?")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        //utterance.rate = 0.1

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)

    }
}

PlaygroundPage.current.liveView = HelloPurple()
