//
//  ViewController.swift
//  It's a Zoo in There
//
//  Created by Yutong Sun on 1/16/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var label: UILabel!
    var animals: [Animal] = []
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            scrollView.contentSize = CGSize(width: 1179, height: 600)
            self.scrollView.delegate = self
            // Do any additional setup after loading the view.
            let animal1 = Animal(name: "Lion", species: "Lion", age: 5, image: UIImage(named: "Lion")!, soundPath: "lion")
            let animal2 = Animal(name: "Dwen", species: "Cat", age: 4, image: UIImage(named: "Dwen")!, soundPath: "dwen")
            let animal3 = Animal(name: "Kuai", species: "Dog", age: 1, image: UIImage(named: "Kuai")!, soundPath: "kuai")
            
            animals.append(contentsOf: [animal1, animal2, animal3])
            animals.shuffle()
            print(animals)
            label.text = animals[0].species
            
            let buttonWidth: CGFloat = 100
            let buttonHeight: CGFloat = 50
            let spacing: CGFloat = 393
            for i in 0...2 {
                let xPosition = CGFloat(i) * spacing
                var config = UIButton.Configuration.filled()
                config.title = animals[i].name
                config.baseBackgroundColor = UIColor.red
                config.baseForegroundColor = UIColor.white
                config.cornerStyle = .capsule
                let button = UIButton(configuration: config, primaryAction: nil)
                button.setTitle(animals[i].name, for: .normal)
                button.tag = i
                
                button.frame = CGRect(x: xPosition, y: 40, width: buttonWidth, height: buttonHeight)
                button.titleLabel?.font =  .systemFont(ofSize: 33)
                scrollView.addSubview(button)
                
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                
                let imageView = UIImageView(image: animals[i].image)
                let imgXPos: Int = 393 * i
                imageView.frame = CGRect(x: imgXPos, y: 145, width: 393, height: 393)
                scrollView.addSubview(imageView)
                
            }
        }
    @objc func buttonTapped(_ button: UIButton) {
            let selectedAnimal = animals[button.tag]
            
            //https://www.youtube.com/watch?v=yVwQ7oWMxnk
            let alert = UIAlertController(title: selectedAnimal.name, message: "This \(selectedAnimal.species) is \(selectedAnimal.age) year(s) old.", preferredStyle: .alert)
            
            
            alert.addAction(UIAlertAction(title: "Play Sound", style: .default, handler: { _ in
                self.playSound(for: selectedAnimal)
                print(selectedAnimal.description)
            }))
            
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            // Present the alert
            self.present(alert, animated: true, completion: nil)
    }
    
    func playSound(for animal: Animal) {
        print(animal.soundPath)
        // https://www.youtube.com/watch?v=2kflmGGMBOA
        let urlString = Bundle.main.path(forResource: animal.soundPath, ofType: "MP3")
        do {
            guard let urlString = urlString else{
                return
            }
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            guard let player = player else{
                return
            }
            player.play()
        } catch {
                // Handle the error
            print("Error playing sound.")
        }
    }
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth: CGFloat = 393
        let page = round(scrollView.contentOffset.x / pageWidth)
        let animal: Animal = animals[Int(page)]
        label.text = animal.species

        let fractionalPage = scrollView.contentOffset.x / pageWidth
        let pageDifference = (fractionalPage - CGFloat(page))
        label.alpha = 1 - abs(pageDifference * 2)
    }
}


