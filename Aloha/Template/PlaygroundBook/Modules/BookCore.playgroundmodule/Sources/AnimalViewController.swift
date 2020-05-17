//
//  AnimalViewController.swift
//  BookCore
//
//  Created by Anderson Alencar on 16/05/20.
//

import UIKit
import Foundation

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
        button.setTitle("Voltar", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor(red: 0.90, green: 0.76, blue: 0.50, alpha: 1.00)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    public var animalName: String?
    
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
    }
    
    public func animalDescription(name: String) -> String {
        switch name {
        case "caranguejo":
            return "Caranguejo"
        case "polvo":
            return "polvo safado"
        case "lula":
            return "lulinha"
        default:
            return "peixe leao"
        }
    }
    

}
