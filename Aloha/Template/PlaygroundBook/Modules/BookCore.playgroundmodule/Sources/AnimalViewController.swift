//
//  AnimalViewController.swift
//  BookCore
//
//  Created by Anderson Alencar on 16/05/20.
//

import UIKit
import Foundation
import AVFoundation


public class AnimalViewController: UIViewController {

    
    
    public lazy var imageView: UIImageView = {
        let animalImage = UIImageView()
        animalImage.image = UIImage(named: "\(animalName!)Modal")
        animalImage.contentMode = .scaleAspectFit
        animalImage.translatesAutoresizingMaskIntoConstraints = false
        animalImage.clipsToBounds = true
        return animalImage
    }()
    
    public lazy var animalDescription: UILabel = {
        let descrition = UILabel()
        descrition.text = self.animalDescription(name: "\(animalName!)")
        descrition.translatesAutoresizingMaskIntoConstraints = false
        descrition.numberOfLines = 0
        descrition.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        descrition.adjustsFontSizeToFitWidth = true
        descrition.textAlignment = .justified
        return descrition
    }()
    
    public lazy var returnButton:UIButton = {
        var button = UIButton()
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 0.90, green: 0.76, blue: 0.50, alpha: 1.00)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    public var animalName: String?
    var utterance = AVSpeechUtterance()
    var synthesizer = AVSpeechSynthesizer()

    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(animalDescription)
        view.addSubview(returnButton)
        setUpConstraints()
    }
    
    
    public func setUpConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            animalDescription.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            animalDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            animalDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            animalDescription.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            returnButton.topAnchor.constraint(equalTo: animalDescription.bottomAnchor, constant: 10),
            returnButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            returnButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            returnButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    @objc public func back() {
        self.dismiss(animated: true, completion: nil)
        synthesizer.stopSpeaking(at: .immediate)
    }
    
    public func animalDescription(name: String) -> String {
        switch name {
        case "caranguejo":
            return "Did you know that the crab is about 180 million years old? Most of them can be found in the sea, but they can be found in fresh water, rocky caves or in mangroves. They love a mud!"
        case "polvo":
            return "Octopuses have 8 tentacles, with suction cups to hold very tightly on objects. They are very smart and they can change color did you know? They do this to escape predators and when they don't feel safe"
        case "lula":
            return "The squid have 10 tentacles, just like the octopuses, some of them can change the color of the skin. They release powerful jets of water to escape quickly from their predators."
        default:
            return "Lionfish have many red stripes on their bodies, they are not very large but they have many spines to protect themselves, they live mainly in the Caribbean. Someday we can travel there to meet them"
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        speechAnimal()
    }
    
    public func speechAnimal() {
        utterance = AVSpeechUtterance(string: "\(self.animalDescription(name: "\(animalName!)"))")
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.3
        synthesizer.speak(utterance)
    }
    

}
