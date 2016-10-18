//
//  FirstViewController.swift
//  Univeristy Radio Nottingham
//
//  Created by Univeristy Radio Nottingham on 20/09/2016.
//  Copyright © 2016 Univeristy Radio Nottingham. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController {
    
    var playerItem:AVPlayerItem?
    var player:AVPlayer!

    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Setup")
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        let urlString = "http://128.243.106.145:8080/urn_high.mp3"
        let url = NSURL(string: urlString)!
        player = AVPlayer(url: url as URL)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        print("Handler Added")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playButtonTapped(sender: AnyObject) {
        if player?.rate == 0
        {
            player!.play()
            playButton.setTitle("Pause", for: .normal)
            print("Start")
        } else {
            player!.pause()
            playButton.setTitle("Play", for: .normal)
            print("Stop")
        }
    }


}

