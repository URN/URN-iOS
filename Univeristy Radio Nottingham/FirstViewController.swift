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
    
    
    @IBOutlet weak var txtMessage: UITextField!
    
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
    
    @IBAction func msgSend(_ sender: UITextField) {
        sendMessage()
    }
    func sendMessage()	{
        //        let dict = ["message": "Jack is happy"]
        //
        //        if let json = try? JSONSerialization.data(withJSONObject: dict, options: []) {
        //            if let content = String(data: json, encoding: String.Encoding.utf8) {
        //                // here `content` is the JSON dictionary containing the String
        //                print(content)
        //            }
        //        }
        //
        // create post request
        let mesUrl = NSURL(string: "http://urn1350.net/api/send_message")!
        let request = NSMutableURLRequest(url: mesUrl as URL)
        request.httpMethod = "POST"
        request.setValue("URN iOS", forHTTPHeaderField: "User-Agent")
        
        // insert json data to the request
        //        let mapDict = [ "1":"First", "2":"Second"]
        
        //        let json2 = ["message":"Hi there"] as [String : Any]
        
        //        do {
        //            let jsonData = try JSONSerialization.data(withJSONObject: json2)
        
        //            let string1 = String(data: jsonData, encoding: String.Encoding.utf8) ?? "Data could not be printed"
        //            print(string1)
        // insert json data to the request
        //            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let postString = "message=" + txtMessage.text!
        print (postString)
        request.httpBody = postString.data(using: .utf8)
        
        var requestDidSucceed = false
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                print(error!.localizedDescription)
                return
            }
            if let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:String]{
                print(responseJSON!)
                
                    if responseJSON! == ["status":"success", "message": "Message sent successfully"]{
                        requestDidSucceed = true
                        
//                        self.didSend(succeed: requestDidSucceed)
                        
                    }
            }

        }
        
        task.resume()
        
        // Clear text box
        self.txtMessage.text = ""
        
        print (requestDidSucceed)
        
        
    }
    
    func didSend(succeed: Bool){
        if succeed {
            print ("Message sent successfully")
            
//            // Clear text box
//            self.txtMessage.text = ""
            
            
            //Popup to say message sent
            let alert = UIAlertController(title: "Alert", message: "Message Sent", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
}

