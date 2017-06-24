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
    
    var startTime: TimeInterval? = nil
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func update(){
        
        //Optional Binding
        if let startTime = self.startTime {
            
            //スタートボタン押下時からの経過時刻を取得
            let t:Double = Date.timeIntervalSinceReferenceDate - startTime
            
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
        
        //タイマーを停止
        self.timer.invalidate()
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        
        //タイマーを初期化
        self.startTime = nil
        self.timerLabel.text = "00:00:00"
    }
    
}

