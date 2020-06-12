//
//  SelectTimerViewController.swift
//  ios-clock
//
//  Created by user169339 on 6/6/20.
//

import UIKit

class SelectTimerViewController: UIViewController {
    
    @IBOutlet weak var SetButton: UIBarButtonItem!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBAction func setTimer() {
        let nav = self.navigationController
        let wvc = (nav?.viewControllers[(nav?.viewControllers.count)! - 2]) as! TimerViewController
        let ti = NSInteger(timePicker.countDownDuration)

        wvc.setTime(second: ti)
        self.navigationController?.popViewController(animated: true)
    }
}
