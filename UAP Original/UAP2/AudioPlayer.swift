//
//  AudioPlayer.swift
//  UAP2
//
//  Created by Miles on 8/24/15.
//  Copyright (c) 2015 Miles. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayer: NSObject {
    
    var Player = AVAudioPlayer()
    var currentAudioPath:NSURL!

//    init (currentAudio: String) {
//        super.init()
//    }
    
    func Play () -> String {
        let currentAudio = setCurrentAudioPath()
        Player = try! AVAudioPlayer(contentsOfURL: currentAudioPath)
        Player.prepareToPlay()
        Player.play()
        return currentAudio
    }
    
    func Pause () {
        Player.pause()
    }
    
    func setCurrentAudioPath() -> String {
        var currentAudio = "Twilight Poem"
        currentAudioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(currentAudio, ofType: "mp3")!)
        return currentAudio
    }
    

}