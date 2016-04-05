//
//  ViewController.swift
//  UAP2
//
//  Created by Miles on 7/27/15.
//  Copyright (c) 2015 Miles. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audioPlayer = AudioPlayer()
//    var audioPlayer = AudioPlayer(currentAudio:"")
    var currentAudioPath:NSURL!
    @IBOutlet var audioTitle : UILabel!
    @IBOutlet weak var playButton: UIButton! {
        didSet {
            playButton.setTitle("Play", forState: UIControlState.Normal)
        }
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        print("tap")
//        if playButton.titleLabel?.text == "Pause" {
//            audioPlayer.Pause()
//            playButton.setTitle("Play", forState: UIControlState.Normal)
//        }
//    }
//    
    
    @IBAction func tapGesture(sender: UITapGestureRecognizer) {
        print(sender.numberOfTouches())
        if sender.numberOfTouches() == 1 {
            print("one tap")
            audioPlayer.Pause()
            playButton.setTitle("Play", forState: UIControlState.Normal)
        }
    }
    
    
    @IBAction func playAudio () {
        
        if playButton.titleLabel?.text == "Play" {
            audioTitle.text = audioPlayer.Play()
            playButton.setTitle("Pause", forState: UIControlState.Normal)
            
        } else {
            audioPlayer.Pause()
            playButton.setTitle("Play", forState: UIControlState.Normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

