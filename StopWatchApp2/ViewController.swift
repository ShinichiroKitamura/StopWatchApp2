//
//  ViewController.swift
//  StopWatchApp2
//
//  Created by 北村槙一朗 on 2017/06/24.
//  Copyright © 2017年 北村槙一朗. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var startTime: TimeInterval? = nil
    var timer = Timer()
    var elapsedTime: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //start: true, stop: false, reset: false
        setButtonEnabled(start: true, stop: false, reset: false)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setButtonEnabled(start: Bool, stop: Bool, reset: Bool){
        self.startButton.isEnabled = start
        self.stopButton.isEnabled = stop
        self.resetButton.isEnabled = reset

    }
    
    func update(){
        
        //Optional Binding
        if let startTime = self.startTime {
            
            //スタートボタン押下時からの経過時刻を取得
            let t:Double = Date.timeIntervalSinceReferenceDate - startTime + self.elapsedTime
            
            //取得した時刻をラベル表示用定数に設定
            let min = Int(t / 60)
            let sec = Int(t) % 60
            let msec = Int((t - Double(sec)) * 100.0)
            
            //時刻をラベルに設定
            self.timerLabel.text = String(
                format:"%02d:%02d:%02d"
                        , min, sec, msec
            )
        }
    }
    
    @IBAction func startTimer(_ sender: Any) {
        
        //start: false, stop: true, reset: false
        setButtonEnabled(start: false, stop: true, reset: false)

        //起動時間を取得
        self.startTime = Date.timeIntervalSinceReferenceDate
        
        //タイマーを起動
        self.timer = Timer.scheduledTimer(
            timeInterval: 0.01
            , target: self
            , selector: #selector(self.update)
            , userInfo: nil
            , repeats: true
        )
    }

    
    @IBAction func stopTimer(_ sender: Any) {
        
        //start: true, stop: false, reset: true
        setButtonEnabled(start: true, stop: false, reset: true)
        
        //タイマーを停止
        self.timer.invalidate()
        
        //タイマー停止時の経過時間を取得
        if let startTime = self.startTime {
            self.elapsedTime += Date.timeIntervalSinceReferenceDate - startTime
        }
        
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        
        //start: true, stop: false, reset: false
        setButtonEnabled(start: true, stop: false, reset: false)
        
        //タイマーを初期化
        self.startTime = nil
        self.timerLabel.text = "00:00:00"
        self.elapsedTime = 0.0
    }
    
}

