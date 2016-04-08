//
//  MusicPlayerController.swift
//  UAP
//
//  Created by Tingbo Chen on 4/4/16.
//  Updated by Adrian Bolinger on 4/6/16.
//  Copyright © 2016 NoVA. All rights reserved.
//

import UIKit

/*
 These notification keys are declared above the class so all the classes can "see" it.
 */
let playNotificationKey = "playNotification"
let stopNotificationKey = "stopNotification"

class MusicPlayerController: UIViewController {

    var audioPlayer = AudioPlayer()
    var animator = Animator()
    
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
    
    // Gesture recognizers
    let nextSongGesture = UISwipeGestureRecognizer()
    let priorSongGesture = UISwipeGestureRecognizer()
    
    // MARK: - View Controller Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         Further along, we'll want to tweak the way the audio player is fed files. For now, just initializing it with the array of songs specified in the testSongArray
         */
        
        // Initialize the audio player before the notifications
        audioPlayer = AudioPlayer(arrayOfMP3FileNames: testSongArray)
        
        /*
         Set up view controller to receive notifications posted by AudioPlayer methods
         Constants for these methods are declared at the top
         AudioPlayerClass posts notifications when it's playing/stopped. The observers below will listen for those notifications and update the image on the button apropriately.
         */

        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(MusicPlayerController.audioPlayerNotificationHandler(_:)), name: playNotificationKey, object: nil)
        notificationCenter.addObserver(self, selector: #selector(MusicPlayerController.audioPlayerNotificationHandler(_:)), name: stopNotificationKey, object: nil)
        
        configureGestureRecognizers()
        configureColors()
        
        // Assign tags to buttons to determine which one is the sender
        rewindButton.tag = 0
        playButton.tag = 1
        fastForwardButton.tag = 2
    }
    
    deinit {
        // Remove notifications
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - Gesture Recognizer Methods
    func configureGestureRecognizers() {
        // configure nextSongGesture
        nextSongGesture.direction = .Left
        nextSongGesture.addTarget(self, action: #selector(MusicPlayerController.pressedFastf(_:)))
        view.addGestureRecognizer(nextSongGesture)
        
        // configure priorSongGesture
        priorSongGesture.direction = .Right
        priorSongGesture.addTarget(self, action: #selector(MusicPlayerController.pressedRewind(_:)))
        view.addGestureRecognizer(priorSongGesture)
    }
    
    // MARK: - UI Appearance Attribute Configuration
    
    func configureColors() {
        audioControlsContainer.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        audioControlsContainer.layer.borderWidth = 2
        audioControlsContainer.layer.cornerRadius = 10.0
        audioControlsContainer.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        //Tint buttons
        /*
         These buttons are PDF vectors, so I specified "render as template image" on Assets.xcassets so it doesn't need to be done in code.
         */
        let mediaPlayerButtons = [rewindButton,playButton,fastForwardButton]
        
        for button in mediaPlayerButtons {
            button.tintColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
        }
    }

    func audioPlayerNotificationHandler(notification: NSNotification) {
        print("Notification received from \(notification.name)")
        updatePlayButtonImage(self)
    }
    
    func updatePlayButtonImage(sender: AnyObject) {
        if let player = audioPlayer.player {
            // Add more comprehensive switch and call animation only when necessary
            let currentImage = playButton.currentImage
            let pauseImage = UIImage(named: "Pause Filled")
            let playImage = UIImage(named: "Play Filled")
            
            print("updatePlayButtonImage's sender: \(sender)")
            
            /*
             The switch statement below runs through 4 different scenarios driven by:
             1) whether the audioPlayer is playing
             2) whether the currentImage is equal to the one that should be displayed
             
             A generic bool is specified on the switch and for each scenario, we compare the currently displayed image to the desired image and return true or false.
             */
            
            switch (player.playing, Bool()){
            
            case (true, image(currentImage!, isEqualTo: pauseImage!)):
                print("case 1")
                // FIXME: figure out circumstances to make the image pause/stop
                playButton.setImage(UIImage(named: "Pause Filled"), forState: .Normal)
                if sender.isKindOfClass(UIButton) {
                    animator.animateControl(playButton)
                }
                
            case (true, image(currentImage!, isEqualTo: playImage!)):
                print("case 2")
                playButton.setImage(UIImage(named: "Pause Filled"), forState: .Normal)
                
            case (false, image(currentImage!, isEqualTo: pauseImage!)):
                print("case 3")
                // FIXME: figure out circumstances to make the image pause/stop
                playButton.setImage(UIImage(named: "Play Filled"), forState: .Normal)
                
                // tags added to buttons in viewDidLoad
                // tags enable the method to see who the sender is
                // we only want the button animating if it's a button sending it
                if let senderTag = sender.tag {
                    if senderTag == 1 {
                        animator.animateControl(playButton)
                    }
                }

            case (false, image(currentImage!, isEqualTo: playImage!)):
                print("case 4")
                playButton.setImage(UIImage(named: "Play Filled"), forState: .Normal)
                animator.animateControl(playButton)
            default:
                print("default case")
                return
            }
        }
    }
    
    // This method compares two images to see if they're the same thing
    // updatePlayButtonImage(_:) uses this method to return a Boolean
    func image(currentImage: UIImage, isEqualTo desiredImage: UIImage) -> Bool {
        let currentImageData = UIImagePNGRepresentation(currentImage)
        let desiredImageData = UIImagePNGRepresentation(desiredImage)
        
        return currentImageData!.isEqual(desiredImageData)
    }

    // MARK: - Media player controls
    
    @IBAction func volumeAction(sender: AnyObject) {
        audioPlayer.volume = volumeOutlet.value
    }
    
    @IBAction func scrubAction(sender: AnyObject) {
        audioPlayer.player!.currentTime = Double(scrubOutlet.value) * audioPlayer.player!.duration
    }
    
    @IBAction func pressedPlay(sender: AnyObject) {
        if let player = audioPlayer.player {
            switch player.playing {
            case true:
                audioPlayer.player?.pause()
            case false:
                audioPlayer.player?.play()
            }
            updatePlayButtonImage(sender)
        }
    }
    
    @IBAction func pressedFastf(sender: NSObject) {
        self.audioPlayer.nextSong(true)
        
        // We do a switch here so it doesn't animate on a swipe gesture
        switch sender {
        case nextSongGesture:
            print("gestureRecognizer sent this")
        case fastForwardButton as UIButton:
            print("fastForwardButton sent this")
            animator.animateControl(sender as! UIControl)
        default:
            print("something else sent this")
        }
        
        if audioPlayer.player!.playing == false {
            audioPlayer.pause()
        } else if audioPlayer.player!.playing == true {
            audioPlayer.play()
        }
    }
    
    @IBAction func pressedRewind(sender: NSObject) {
        audioPlayer.previousSong()
        
        // We do a switch here so it doesn't animate on a swipe gesture
        switch sender {
        case priorSongGesture:
            print("gestureRecognizer sent this")
        case rewindButton:
            animator.animateControl(sender as! UIControl)
        default:
            print("something else sent this")
        }
        
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
