//
//  Audio.swift
//  UAP2
//
//  Created by nimdir on 12/7/15.
//  Copyright © 2015 Miles. All rights reserved.
//

import Foundation
import AVKit

struct Audio {
    var name: String?
    var path: String?
    
    init(index: Int) {
        let audioLibrary = AudioLibrary().library
        let audioDictionary = audioLibrary[index]
        
        name = audioDictionary["name"]
        path = audioDictionary["path"]
    }
}
