//
//  musicUI.swift
//  AlanWalker
//
//  Created by Hady on 9/12/20.
//  Copyright © 2020 HadyOrg. All rights reserved.
//

import UIKit
import AVFoundation

class musicUI: UIViewController , AVAudioPlayerDelegate{
    
    var audio : AVAudioPlayer! = nil
    var sec = 0
    var min = 0

    var musicArray = [MusicDataModel] ()
    var currentIndexPath : Int?
    
    @IBOutlet var musicNameLabel: UILabel!
    
    @IBOutlet var albumNameLabel: UILabel!
    
    @IBOutlet var songImage: UIImageView!
    
    @IBOutlet var totalTimeLabel: UILabel!
    
    @IBOutlet var currentTimeLabel: UILabel!
    
    
    var isRunning = false
    var runningTime = Timer()
    
    @IBOutlet var ProgressMusciBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Start Playing The Selected Music
        handleTheUpdateOfUI()
        
    }
    
    //MARK: - Playing Audio Functionaliy
    @IBAction func fastForward(_ sender: Any) {
       
        currentIndexPath! += 1
        
        if currentIndexPath! < musicArray.count , currentIndexPath! >= 0
        {
            handleTheUpdateOfUI()
        }
        else
        {
            currentIndexPath = 0
            handleTheUpdateOfUI()
        }
    }
    
    @IBOutlet weak var playBtn: UIButton!
    @IBAction func play(_ sender: Any)
    {
        
        updateUI()
    }
    
    
    @IBAction func rewind(_ sender: Any)
    {
       
        currentIndexPath! -= 1
      
        if currentIndexPath! < musicArray.count , currentIndexPath! >= 0{
       
            handleTheUpdateOfUI()
        }
            
        else {
       
            currentIndexPath = 0
            handleTheUpdateOfUI()
        }
    }
    
    
    
    //MARK: - Update the UI Code
    func updateUI() {
        if isRunning {
            
            pauseMusicUI()
      
        }
            
        else{
            
            playMusicUI()
       
        }
        
    }
    
    @objc func updateProgress () {
        var progressAudioTime : Float = 0.0
        
        
        progressAudioTime = musicArray[currentIndexPath!].musicTime
        
        
        if ProgressMusciBar.progress >= 1 - (1 / progressAudioTime) {
           
            runningTime.invalidate()
            ProgressMusciBar.progress = 0
            sec = 0 ; min = 0 ; showCurrentTime()
            playBtn.setImage(UIImage(named: "play"), for: .normal)
        }
        else {
            
            if sec == 59
            {
                min += 1
                sec = 0
                showCurrentTime()
            }
            else
            {
                sec += 1   ; showCurrentTime()
                
            }
            
            ProgressMusciBar.progress += 1 / progressAudioTime
            
            ProgressMusciBar.setProgress(ProgressMusciBar.progress, animated: true)
            
        }
    }
    // Show the current music time
    func showCurrentTime ()
    {
        currentTimeLabel.text = "\(min.toString()):\(sec.toString())"
    }
    
    // MARK: - playingMusic
    
    func playMusic (playingAudioName : String)
    {
        let url = Bundle.main.url(forResource: playingAudioName, withExtension: ".mp3")!
        
        do {
            audio = try AVAudioPlayer(contentsOf: url)
        }
        catch
        {
            print("Error while playing audio :: \(error)")
        }
        musicArray[currentIndexPath!].musicTime = Float(audio.duration)
        audio.play()
    }

    
    func handleTheUpdateOfUI()
    {
        
        if playBtn.imageView?.image != UIImage(named: "play") , audio != nil
        {

            pauseMusicUI()
        }
        
        sec = 0
        min = 0
        ProgressMusciBar.progress = 0
        showCurrentTime()
        
        playMusic(playingAudioName: musicArray[currentIndexPath!].musicName)
        updateUI()
        musicNameLabel.text = musicArray[currentIndexPath!].musicName
        totalTimeLabel.text = audio.durationWithMinAndSec()
        albumNameLabel.text = musicArray[currentIndexPath!].musicAlbum
        songImage.image = UIImage(named: musicArray[currentIndexPath!].musicImage)
        

    }
    
    func pauseMusicUI()
    {
        isRunning.toggle()
        runningTime.invalidate()
        audio.pause()
        playBtn.setImage(UIImage(named: "play"), for: .normal)
    }
    
    
    func playMusicUI()
    {
        isRunning.toggle()
        playBtn.setImage(UIImage(named: "pause"), for: .normal)
        audio.play()
        runningTime = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        
    }
}


//MARK: - AVAudioPlayer Extension to handle the total time view

extension AVAudioPlayer {
    func durationWithMinAndSec () -> String {
        print(self.duration)
        
        let durationInt  = Int(self.duration)
        return "\(durationInt / 60):\(durationInt % 60 )"
        
    }
}

//MARK: - Int Extension Return the time in "00:00" Format
extension Int {
    func toString() -> String {
        if (self < 10 && self >= 0) {
            return "0\(Int(self))"
        } else {
            return "\(Int(self))"
        }
    }
}
