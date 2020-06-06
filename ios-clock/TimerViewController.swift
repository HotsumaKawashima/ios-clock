//
//  TimerViewController.swift
//  ios-clock
//
//  Created by Carlos andres Diaz bravo  on 2020-06-04.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    
    var seconds = 160
    var count = 160
    var timer = Timer()
    var isTimerRunning = false
    var resumeTapped = false
    
    @IBOutlet weak var resetTimerButton: UIButton!
    
    @IBOutlet weak var startStopTimerButton: UIButton!
    
    @IBOutlet weak var pausetimerbutton: UIButton!
    
    @IBAction func resetTimerButton(_ sender: Any) {
        timer.invalidate()
        count = seconds
        timerLabel.text = timeString(time: TimeInterval(count))
        isTimerRunning = false
    }
    
    @IBAction func pauseTimerButton(_ sender: Any) {
        if self.resumeTapped == false {
                timer.invalidate()
                self.resumeTapped = true
            
                } else {
                     runTimer()
                     self.resumeTapped = false
                }
    }
    
    @IBAction func startTimerButton(_ sender: Any) {
        if isTimerRunning == false {
        runTimer()
               }
    }
    
    @objc func updateTimer() {
        if count < 1 {
             timer.invalidate()
        } else {
             count -= 1
             timerLabel.text = timeString(time: TimeInterval(count))
        }
    }
    
    func setTime(second: Int) {
        print(second)
        seconds = second
        count = second
        timerLabel.text = timeString(time: TimeInterval(count))
        super.viewDidLoad()
    }
    
    func runTimer() {
         timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        
        isTimerRunning = true
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
    
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = timeString(time: TimeInterval(count))
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
