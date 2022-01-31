//
//  ViewController.swift
//  Magic8Ball
//
//  Created by Алина Бондарчук on 27.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var magicBallImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var settingController: SettingTableViewController!
    
    var answer = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = ""
        
        parse()
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        shake()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        parse()
        messageLabel.alpha = 0
        messageLabel.text = answer
        
        UIView.animate(withDuration: 2.0, delay: 0.5) {
            self.messageLabel.alpha = 1
        }
        
    }
    
    func parse() {
        let urlString = "https://8ball.delegator.com/magic/JSON/%3Cquestion_string%3E"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Failed to decode: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let jsonAnswer = try? decoder.decode(Answers.self, from: data)
                self.answer = jsonAnswer?.magic.answer ?? ""
            } catch {
                self.answer = answerModel.randomElement() ?? "Try again"
                print("Failed to decode: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.duration = 4
        animation.values = [-35.0, 35.0, -30.0, 30.0, -25.0, 25.0, -20.0, 20.0, -15.0, 15.0, -10.0, 10.0, -5.0, 5.0, 0.0]
        magicBallImage.layer.add(animation, forKey: "shake")
    }
}

