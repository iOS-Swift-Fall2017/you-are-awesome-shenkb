//
//  ViewController.swift
//  You Are Awesome!
//
//  Created by Kaining on 9/5/17.
//  Copyright © 2017 Kaining. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    //MARK: - Properties
    @IBOutlet weak var awesomeImage: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var soundSwitch: UISwitch!
    var awesomePlayer = AVAudioPlayer()
    var index = -1
    var imageNumber = -1
    var soundNumber = -1
    let numberOfImages = 9
    let numberOfSounds = 6
    
    // This code executes when the view controller loads
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        // Can we load in the file SoundName?
        if let sound = NSDataAsset(name: soundName){
            // check if sound.data is a sound file
            do{
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                // if sound.data is not a valid sound file
                print("ERROR: data in \(soundName) couldn't be played as a sound.")
            }
            
            
        } else{
            // if reading in the NSDataAsset didn't work, tell the user / repot the error.
            print("Error: file \(soundName) didn't load")
        }
    }
    
    func nonRepeatingRandomNumber(lastNumber: Int, maxValue: Int) -> Int{
        var newIndex = -1
        repeat{
            newIndex = Int(arc4random_uniform(UInt32(maxValue)))
        } while lastNumber == newIndex
        return newIndex
    }
    // MARK: - Actions
    @IBAction func soundSwitchPressed(_ sender: UISwitch) {
        if !soundSwitch.isOn && soundNumber != -1 {
                // stop playing
                awesomePlayer.stop()
        }
    }
    
    @IBAction func messageButtonPressed(_ sender: UIButton) {
        let messages = ["You Are Fantastic!",
                        "You Are Great!",
                        "You Are Amazing!",
                        "You Brighten My Day!", 
                        "I can't waiit to see your app!",
                        "Fabulous! That's how you did it!!!",
                        "You Are Da Bomb!"
                        ]
//        var newIndex = -1

        // Show a message
        
//        repeat{
//            newIndex = Int(arc4random_uniform(UInt32(messages.count)))
//        } while index == newIndex
        
        index = nonRepeatingRandomNumber(lastNumber: index, maxValue: messages.count)
        messageLabel.text = messages[index]
        
        
        // Show an image
        awesomeImage.isHidden = false // show the image

//        repeat{
//            newIndex = Int(arc4random_uniform(UInt32(numberOfImages)))
//        } while imageNumber == newIndex
        
        imageNumber = nonRepeatingRandomNumber(lastNumber: imageNumber, maxValue: numberOfImages )
        awesomeImage.image = UIImage(named: "image\(imageNumber)")
        
        if soundSwitch.isOn == true {
            // Get a random number to use in our soundName file
            //        repeat{
            //            newIndex = Int(arc4random_uniform(UInt32(numberOfSounds)))
            //        } while soundNumber == newIndex
            
            soundNumber = nonRepeatingRandomNumber(lastNumber: soundNumber, maxValue: numberOfSounds)
            
            // Play a sound
            let soundName = "sound\(soundNumber)"
            playSound(soundName: soundName, audioPlayer: &awesomePlayer)
        }

    }

}
