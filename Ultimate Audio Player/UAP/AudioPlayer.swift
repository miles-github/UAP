//
//  AudioPlayer.swift
//  UAP
//
//  Created by Adrian Bolinger on 4/5/16.
//  Copyright © 2016 NoVA. All rights reserved.
//

import UIKit
import AVFoundation

class AudioPlayer: NSObject, AVAudioPlayerDelegate {
    
    /* The player property will be an instance of the AVAudioPlayer class,
     which we will use to play, pause, and stop the MP3s. */
    var player: AVAudioPlayer?
    
    /*
     Get system volume
     */
    var volume = AVAudioSession.sharedInstance().outputVolume
    
    /* The currentTrackIndex variable keeps track of which MP3 is currently playing.*/
    var currentTrackIndex = 0
    
    /* Finally, the tracks variable will be an array of the paths to the list of MP3s
     that are included in the application's bundle.*/
    var tracks: [String] = [String]()

    override init() {
        super.init()
    }

    // this is the initializer for a playlist
    init(arrayOfMP3FileNames: [String]) {
        for fileName in arrayOfMP3FileNames {
            // get the path of the file...
            let fileNamePath: String = NSBundle.mainBundle().pathForResource(fileName, ofType: "mp3")!
            // ...and add it to the tracks array
            tracks.append(fileNamePath)
        }
        
        super.init()
        queueTrack()
    }
    
    // this is the initializer for 1 sound
    init(fileName: String) {
        // Need to get location of file in bundle
        let fileNamePath: String = NSBundle.mainBundle().pathForResource(fileName, ofType: "")!
        // Then add the filename to the tracks array of strings
        tracks.append(fileNamePath)
        super.init()
        queueTrack()
    }
    
    func queueTrack() {
        
        let url = NSURL.fileURLWithPath(tracks[currentTrackIndex] as String)
        
        do {
            player = try AVAudioPlayer(contentsOfURL: url) // Thread 1: breakpoint 1.1
            player?.delegate = self
            player?.prepareToPlay()
        } catch let error as NSError {
            NSLog("queTrack error \(error.debugDescription)")
            // SHOW ALERT OR SOMETHING
        }
    }
    
    func play() {
        if player?.playing == false {
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                player?.play()
                NSNotificationCenter.defaultCenter().postNotificationName(playNotificationKey, object: self)
            } catch {
                print(error)
            }
        }
        print("AudioPlayer: playing song at index: \(currentTrackIndex)")
    }
    
    func stop() {
        if player?.playing == true {
            player?.stop()
            NSNotificationCenter.defaultCenter().postNotificationName(stopNotificationKey, object: self)
            player?.currentTime = 0
        }
        print("AudioPlayer stop() called")
    }
    
    func pause() {
        if player?.playing == true {
            player?.pause()
            // FIXME: if we want to pause later, change the notification here and add one on MusicPlayerController
            NSNotificationCenter.defaultCenter().postNotificationName(stopNotificationKey, object: self)
        }
        print("AudioPlayer pause() called")
    }
    
    func nextSong(songFinishedPlaying: Bool) {
        var playerWasPlaying = false
        if player?.playing == true {
            player?.stop()
            playerWasPlaying = true
        }
        
        currentTrackIndex += 1
        if currentTrackIndex >= tracks.count {
            currentTrackIndex = 0
        }
        
        queueTrack()
        if playerWasPlaying || songFinishedPlaying {
            player?.play()
        }
    }
    
    func previousSong() {
        var playerWasPlaying = false
        if player?.playing == true {
            player?.stop()
            playerWasPlaying = true
        }
        
        currentTrackIndex -= 1
        if currentTrackIndex < 0 {
            currentTrackIndex = tracks.count - 1
        }
        
        queueTrack()
        if playerWasPlaying {
            player?.play()
        }
    }
    
    func getCurrentTimeAsString() -> String {
        var seconds = 0
        var minutes = 0
        
        if let time = player?.currentTime {
            // handle the integer
            minutes = (Int(time) / 60) % 60
            seconds = Int(time) % 60
        }
        return String(format: "%0.2d:%0.2d", minutes, seconds)
    }
    
    
    func getProgress() -> Float {
        var theCurrentTime = 0.0
        var theCurrentDuration = 0.0
        if let currentTime = player?.currentTime, duration = player?.duration {
            theCurrentTime = currentTime
            theCurrentDuration = duration
        }
        return Float(theCurrentTime / theCurrentDuration)
    }
    
    func timeDurationOfSound(fileName: String) -> String {
        // TODO: catch error if there's no filename
        // Takes filename argument and determines path
        var outputString: String = ""
        
        if NSBundle.mainBundle().pathForResource(fileName, ofType: "") == nil {
            print("** ALERT!!!: \(fileName) not found **")
        } else {
            let fileNamePath: String = NSBundle.mainBundle().pathForResource(fileName, ofType: "")!
            print(fileName)
            let fileURL = NSURL(fileURLWithPath: fileNamePath)
            let asset = AVURLAsset(URL: fileURL)
            let audioDuration = asset.duration
            let audioDurationInSeconds = CMTimeGetSeconds(audioDuration)
            
            var minutes: Int = Int()
            var seconds: Int = Int()
            
            let time = Int(audioDurationInSeconds)
            minutes = (time / 60) % 60
            seconds = time % 60
            
            outputString = String(format: "%0.2d:%0.2d", minutes, seconds)
        }
        
        return outputString
    }
    
    // Take an array of strings, spit out the total duration of the songs within the fileName array
    func timeDurationOfSoundArray(arrayOfFileNames: NSArray) -> String {
        // set a variable for total time
        var totalAudioDuration = Float64()
        // run through the array of filenames
        for fileName in arrayOfFileNames {
            // get the path fo the filename in the bundle
            let fileNamePath: String = NSBundle.mainBundle().pathForResource(fileName as? String, ofType: "")!
            // create an url for it
            let fileURL = NSURL(fileURLWithPath: fileNamePath)
            // create an AVURLAsset
            let asset = AVURLAsset(URL: fileURL)
            // get the duration of the asset
            let audioDuration = asset.duration
            // convert the duration to seconds
            let audioDurationInSeconds = CMTimeGetSeconds(audioDuration)
            // add the seconds to totalAudioDuration
            totalAudioDuration = totalAudioDuration + audioDurationInSeconds
        }
        
        // reformat total time as 00:00
        var minutes: Int = Int()
        var seconds: Int = Int()
        
        let time = Int(totalAudioDuration)
        minutes = (time / 60) % 60
        seconds = time % 60
        
        return String(format: "%0.2d:%0.2d", minutes, seconds)
    }
    
    
    func setMyVolume(volume: Float) {
        player?.volume = volume
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        if currentTrackIndex == tracks.count - 1 {
            print("end of playlist reached")
            player.stop()
            
            // Posts notification that resets buttons on various view controllers
            // TODO: figure out what notifications need to be posted to update UI, etc.
        }
            
        else if flag == true {
            print("advance to next track")
            nextSong(true)
        }
    }
}
