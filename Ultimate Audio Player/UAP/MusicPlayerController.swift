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

    var av_plyr: AVAudioPlayer = AVAudioPlayer()
    
    var origImg_play = UIImage(named: "Play Filled")!
    
    var songs_test = ["Battle at the misty valley", "Twilight Poem", "Classical-bwv-bach"]
    
    var songNum = 0
    
    //Temporary Scrubber and Volume Control
    @IBOutlet var volumeOutlet: UISlider!
    @IBOutlet var scrubOutlet: UISlider!
     
    @IBAction func volumeAction(sender: AnyObject) {
     av_plyr.volume = volumeOutlet.value
     }
    @IBAction func scrubAction(sender: AnyObject) {
        av_plyr.currentTime = Double(scrubOutlet.value) * av_plyr.duration
    }

    
    private func mediaControls_init() {
        
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
        if av_plyr.playing == false {
            av_plyr.play()
            
            origImg_play = UIImage(named: "Pause Filled")!
            
            mediaControls_init()
            
            print(av_plyr.duration)
            
        } else if av_plyr.playing == true {
            av_plyr.pause()
            
            origImg_play = UIImage(named: "Play Filled")!
            
            mediaControls_init()
        }
    }
    
    func pressedFastf(button: UIButton) {
        songNum = (songNum + 1)%3
        //print(songNum)
        
        if av_plyr.playing == false {
            avPlyr_init()
            av_plyr.pause()
        } else if av_plyr.playing == true {
            avPlyr_init()
            av_plyr.play()
        }
        
    }
    
    func pressedRewind(button: UIButton) {
        if songNum == 0 {
            songNum = 2
        } else {
            songNum = (songNum - 1)%3
        }
        
        //print(songNum)
        
        if av_plyr.playing == false {
            avPlyr_init()
            av_plyr.pause()
        } else if av_plyr.playing == true {
            avPlyr_init()
            av_plyr.play()
        }
    }
    
    func someAction(button: UIButton) {
        print("some action")
    }
    
    func avPlyr_init() {
        
        self.title = songs_test[songNum]
        
        //Create a path to the mp3 player
        let audioPath = NSBundle.mainBundle().pathForResource(songs_test[songNum], ofType: "mp3")!
        
        do {
            try av_plyr = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
            
        } catch {
            print("error")
        }
        
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateScrubSlider"), userInfo: nil, repeats: true)
        
    }
    
    func updateScrubSlider(){
        scrubOutlet.value = Float(av_plyr.currentTime/av_plyr.duration)
        
        print(scrubOutlet.value)
        
        if scrubOutlet.value >= 0.99 {
            
            songNum = (songNum + 1)%3
            //print(songNum)
            
            if av_plyr.playing == false {
                avPlyr_init()
                av_plyr.pause()
            } else if av_plyr.playing == true {
                avPlyr_init()
                av_plyr.play()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mediaControls_init()
        
        self.avPlyr_init()
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
