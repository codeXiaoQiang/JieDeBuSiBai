//
//  AudioPlayModel.swift
//  百思不得其姐
//
//  Created by yangtao on 3/24/16.
//  Copyright © 2016 yangtao. All rights reserved.
//

import UIKit
import DOUAudioStreamer

class AudioPlayModel: NSObject,DOUAudioFile{//DOUAudioFile

    /** 音频文件路径*/
    var audioURL:NSURL?
    
    func audioFileURL() -> NSURL! {
        
        return audioURL
    }
}

