//
//  MusicPlayerController.swift
//  UAP
//
//  Created by Tingbo Chen on 4/4/16.
//  Copyright © 2016 NoVA. All rights reserved.
//

import UIKit
import AVFoundation

/*
 This is declared above the class so all the classes can "see" it.
 */
let playNotificationKey = "playNotification"
let stopNotificationKey = "stopNotification"

class MusicPlayerController: UIViewController {

    var audioPlayer = AudioPlayer()
    
    var testSongArray = ["Battle at the misty valley", "Twilight Poem", "Classical-bwv-bach"]
    
    /*
     You cannot set the background of a UIStackView, so the audioControlsStackView is embedded within a blank view called audioControlsContainer. The UIView class can have a backgroundColor, while a UIStackView cannot.
     */
    
    // Media Controls background view
    @IBOutlet weak var audioControlsContainer: UIView!
    @IBOutlet weak var audioControlsStackView: UIStackView! // this is tucked in the audioControlsContainer view
    
    // Temporary Scrubber and Volume Control
    @IBOutlet var volumeOutlet: UISlider!
    @IBOutlet var scrubOutlet: UISlider!
    
    // Player Controls
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var fastForwardButton: UIButton!
    
    // MARK: - View Controller Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         Further along, we'll want to tweak the way the audio player is fed files. For now, just initializing it with the array of songs specified in the testSongArray
         */
        audioPlayer = AudioPlayer(arrayOfMP3FileNames: testSongArray)
        
        configureColors()
        
        /*
         AudioPlayerClass posts notifications when it's playing/stopped. The observers below will listen for those notifications nad update the image on the button apropriately.
         */
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector(updatePlayButtonImage()), name: playNotificationKey, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector(updatePlayButtonImage()), name: stopNotificationKey, object: nil)
    }
    
    deinit {
        // Remove notifications
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - UI Appearance Attribute Configuration
    
    func configureColors() {
        audioControlsContainer.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        audioControlsContainer.layer.borderWidth = 2
        audioControlsContainer.layer.cornerRadius = 10.0
        audioControlsContainer.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        //Tint buttons
        /*
         These buttons are PDF vectors, so I specified "render as template image" on Assets.xcassets
         */
        let mediaPlayerButtons = [rewindButton,playButton,fastForwardButton]
        
        for button in mediaPlayerButtons {
            button.tintColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
        }
    }
    
    func updatePlayButtonImage() {
        if let player = audioPlayer.player {
            switch player.playing {
            case true:
                // FIXME: figure out circumstances to make the image pause/stop
                playButton.setImage(UIImage(named: "Pause Filled"), forState: .Normal)
                print("pause button should be displayed")
            case false:
                print("play button should be displayed")
                playButton.setImage(UIImage(named: "Play Filled"), forState: .Normal)
            }
        }
    }
    
    // MARK: - Media player controls
    
    @IBAction func volumeAction(sender: AnyObject) {
        audioPlayer.volume = volumeOutlet.value
    }
    
    @IBAction func scrubAction(sender: AnyObject) {
        audioPlayer.player!.currentTime = Double(scrubOutlet.value) * audioPlayer.player!.duration
    }
    
    @IBAction func pressedPlay(sender: UIButton) {
        if let player = audioPlayer.player {
            switch player.playing {
            case true:
                audioPlayer.player?.pause()
                updatePlayButtonImage()
            case false:
                audioPlayer.player?.play()
                updatePlayButtonImage()
            }
        }
    }
    
    @IBAction func pressedFastf(sender: UIButton) {
        
        self.audioPlayer.nextSong(true)
        
        if audioPlayer.player!.playing == false {
            audioPlayer.pause()
        } else if audioPlayer.player!.playing == true {
            audioPlayer.play()
        }
    }
    
    @IBAction func pressedRewind(button: UIButton) {
        audioPlayer.previousSong()
        
        if audioPlayer.player!.playing == false {
            audioPlayer.pause()
        } else if audioPlayer.player!.playing == true {
            audioPlayer.play()
        }
    }
    
    func updateScrubSlider(){
        scrubOutlet.value = Float(audioPlayer.player!.currentTime/audioPlayer.player!.duration)
        
        if scrubOutlet.value == 1 || scrubOutlet.value == 0 {
            print("updateScrubSlider either at min or max")
        }
    }
}
