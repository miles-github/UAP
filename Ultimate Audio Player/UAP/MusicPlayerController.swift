//
//  MusicPlayerController.swift
//  UAP
//
//  Created by Tingbo Chen on 4/4/16.
//  Copyright © 2016 NoVA. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayerController: UIViewController {

    var audioPlayer = AudioPlayer()
    
    var origImg_play = UIImage(named: "Play Filled")!
    
    var testSongArray = ["Battle at the misty valley", "Twilight Poem", "Classical-bwv-bach"]
    
    //Temporary Scrubber and Volume Control
    @IBOutlet var volumeOutlet: UISlider!
    @IBOutlet var scrubOutlet: UISlider!
     
    @IBAction func volumeAction(sender: AnyObject) {
     audioPlayer.volume = volumeOutlet.value
     }
    @IBAction func scrubAction(sender: AnyObject) {
        audioPlayer.player!.currentTime = Double(scrubOutlet.value) * audioPlayer.player!.duration
    }

    // MARK: - View Controller Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mediaControls_init()
        /*
         Further along, we'll want to tweak the way the audio player is fed files. For now, just initializing
         it with the array of songs specified in the testSongArray
         */
        audioPlayer = AudioPlayer(arrayOfMP3FileNames: testSongArray)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Custom Methods
    
    // FIXME: Most of this can be done with interface builder and a lot less code.
    private func mediaControls_init() {
        
        /*
         TODO: Ideas:
         1) Create media controls on the storyboard
         2) Create IBOutlets on the VC
         3) Only tweak appearance attributes for the various components programatically
         */
        
        //Create a container for buttons
        let containerArea = UIView()
        containerArea.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        containerArea.layer.borderWidth = 2
        containerArea.layer.borderColor = UIColor.lightGrayColor().CGColor
        containerArea.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerArea)
        
        //Add Rewind, Play, Fast Forward
        let origImg_rewind = UIImage(named: "Rewind Filled")!
        let tintedImg_rewind = origImg_rewind.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        let rewindButton = UIButton()
        
        let tintedImg_play = origImg_play.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        let playButton = UIButton()
        
        let origImg_fastf = UIImage(named: "Fast Forward Filled")!
        let tintedImg_fastf = origImg_fastf.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        let fastfButton = UIButton()
        
        //Set button specifications
        let tinted_dict = [rewindButton: tintedImg_rewind, playButton: tintedImg_play, fastfButton: tintedImg_fastf]
        
        let button_ls = [rewindButton,playButton,fastfButton]
        
        for button in button_ls {
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setContentHuggingPriority(251, forAxis: .Horizontal)
            button.setContentCompressionResistancePriority(751, forAxis: .Horizontal)
            button.setImage(tinted_dict[button], forState: .Normal)
            button.tintColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
        }
        
        //Set button actions and add to subviews
        rewindButton.addTarget(self, action: Selector("pressedRewind:"), forControlEvents: .TouchUpInside)
        playButton.addTarget(self, action: Selector("pressedPlay:"), forControlEvents: .TouchUpInside)
        fastfButton.addTarget(self, action: Selector("pressedFastf:"), forControlEvents: .TouchUpInside)
        
        containerArea.addSubview(playButton)
        containerArea.addSubview(rewindButton)
        containerArea.addSubview(fastfButton)
        
        //Add button constraints
        let containerAreaConstraints: [NSLayoutConstraint] = [
            containerArea.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor),
            containerArea.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor),
            containerArea.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor),
            containerArea.heightAnchor.constraintEqualToConstant(70),
            
            rewindButton.trailingAnchor.constraintEqualToAnchor(playButton.leadingAnchor, constant: -30),
            playButton.centerXAnchor.constraintEqualToAnchor(containerArea.centerXAnchor),
            fastfButton.leadingAnchor.constraintEqualToAnchor(playButton.trailingAnchor, constant: 30),
            
            rewindButton.centerYAnchor.constraintEqualToAnchor(containerArea.centerYAnchor),
            playButton.centerYAnchor.constraintEqualToAnchor(containerArea.centerYAnchor),
            fastfButton.centerYAnchor.constraintEqualToAnchor(containerArea.centerYAnchor)
        ]
        
        NSLayoutConstraint.activateConstraints(containerAreaConstraints)
    }
    
    func pressedPlay(button: UIButton) {
        if audioPlayer.player!.playing == false {
            audioPlayer.play()
            
            origImg_play = UIImage(named: "Pause Filled")!
            
            print(audioPlayer.player!.duration)
            
        } else if audioPlayer.player!.playing == true {
            audioPlayer.pause()
            
            origImg_play = UIImage(named: "Play Filled")!
            
            mediaControls_init()
        }
    }
    
    func pressedFastf(button: UIButton) {
        
        self.audioPlayer.nextSong(true)
        
        if audioPlayer.player!.playing == false {
            audioPlayer.pause()
        } else if audioPlayer.player!.playing == true {
            audioPlayer.play()
        }
        
    }
    
    func pressedRewind(button: UIButton) {
        audioPlayer.previousSong()
        
        //print(songNum)
        
        if audioPlayer.player!.playing == false {
            audioPlayer.pause()
        } else if audioPlayer.player!.playing == true {
            audioPlayer.play()
        }
    }
    
    func someAction(button: UIButton) {
        print("some action")
    }
    
    func updateScrubSlider(){
        scrubOutlet.value = Float(audioPlayer.player!.currentTime/audioPlayer.player!.duration)
        
        if scrubOutlet.value == 1 || scrubOutlet.value == 0 {
            
            origImg_play = UIImage(named: "Pause Filled")!
            mediaControls_init()
            
        }
    }
}
