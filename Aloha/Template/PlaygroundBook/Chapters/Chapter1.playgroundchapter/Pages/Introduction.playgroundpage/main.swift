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
import BookCore


class HelloPurple: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .red
//        let utterance = AVSpeechUtterance(string: "Hello, my name is Anderson and I know how difficult it can be to stay at home in this period of isolation. How about having a little fun on the beach with my sister surfing with you?")
//        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//        //utterance.rate = 0.1
//
//        let synthesizer = AVSpeechSynthesizer()
//        synthesizer.speak(utterance)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentMock()
    }
    
    func presentMock() {
        let controller = AnimalViewController()
        controller.modalPresentationStyle  = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
}

PlaygroundPage.current.liveView = HelloPurple()
