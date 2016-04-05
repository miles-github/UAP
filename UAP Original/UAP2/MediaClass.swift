//
//  MediaClass.swift
//  UAP2
//
//  Created by nimdir on 11/2/15.
//  Copyright © 2015 Miles. All rights reserved.
//

import Foundation
import AVKit

class Media:NSObject {
    var mediaType: String = "File"
    var mediaLocation: String
    var mediaSpeed: Double = 1.0
    var mediaPosition: Int = 0
    var mediaPic: String = ""
    
    init(mediaType: String, mediaLoc: String) {
        self.mediaType = mediaType
        self.mediaLocation = mediaLoc
        super.init()
    }
    
    func playMedia () {
        var x=1
    }
    
    func pauseMedia () {
        var x=1
    }
    
    func changeSpeed (speed: Double) {
        mediaSpeed = speed
    }
    
    func ffMedia (Seconds: Int) {
        var x=1
    }
    
    func rewMedia (Seconds: Int) {
        var x=1
    }
    
}
