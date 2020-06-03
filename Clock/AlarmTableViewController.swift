//
//  AlarmTableViewController.swift
//  Clock
//
//  Created by 桑染 on 2020-05-28.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit
import UserNotifications

class AlarmTableViewController: UITableViewController, AddAlarmClockViewControllerDelegate {
    
    var alarmClocks: [Clock] = []
    
    let center = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        tableView.rowHeight = 100
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Alarm"
        let titleAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        navigationController?.navigationBar.largeTitleTextAttributes = titleAttributes
        navigationController?.navigationBar.tintColor = .orange
        navigationController?.navigationBar.barTintColor = .black
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAlarm))
        tableView.register(ClockTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        // clean notification after reopen
        center.removeAllPendingNotificationRequests()
    }
    
    func add(alarm: Clock) {
        alarmClocks.append(alarm)
        tableView.reloadData()
    }
    
    @objc func addAlarm(_ sender: UIBarButtonItem) {
        let addVC = AddAlarmClockViewController()
        addVC.delegate = self
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    @objc func alarmSwitchChange(_ sender: UISwitch) {
        if sender.isOn {
            alarmClocks[sender.tag].isActive = true
            setupNotification(title: alarmClocks[sender.tag].label, identifier: "\(sender.tag)", date: alarmClocks[sender.tag].time, repeated: alarmClocks[sender.tag].repeated, sound: alarmClocks[sender.tag].sound)
            print("on")
            center.getPendingNotificationRequests { (requests) in
                for request in requests {
                    print(request)
                }
            }
        } else {
            alarmClocks[sender.tag].isActive = false
            if alarmClocks[sender.tag].repeated.isEmpty {
                center.removePendingNotificationRequests(withIdentifiers: ["\(sender.tag)"])
            } else {
                for i in 0..<alarmClocks[sender.tag].repeated.count {
                    var identifier = "\(sender.tag)"
                    identifier.append("\(alarmClocks[sender.tag].repeated[i])")
                    center.removePendingNotificationRequests(withIdentifiers: [identifier])
                }
            }
            print("off")
            center.getPendingNotificationRequests { (requests) in
                for request in requests {
                    print(request)
                }
            }
        }
        tableView.reloadData()
    }
    
    func setupNotification(title: String, identifier: String, date: Date, repeated: [Int], sound: String) {
        
        center.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("User has declined notification")
            }
        }
        
        let content = UNMutableNotificationContent()
        content.title = title
        var notificationSound = sound
        notificationSound.append(".mp3")
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(notificationSound))
        
        let components = Calendar.current.dateComponents([.weekday, .hour, .minute], from: date)
        let hour = components.hour
        let minute = components.minute
        
        var triggerDate = DateComponents()
        triggerDate.hour = hour
        triggerDate.minute = minute
        
        if repeated.isEmpty {
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
            let identity = identifier
            let request = UNNotificationRequest(identifier: identity, content: content, trigger: trigger)
            center.add(request) { (error) in
                if error != nil {
                    print("something went wrong")
                }
            }
        } else {
            for i in 0..<repeated.count {
                triggerDate.weekday = repeated[i]
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
                var identity = identifier
                identity.append(contentsOf: "\(triggerDate.weekday!)")
                let request = UNNotificationRequest(identifier: identity, content: content, trigger: trigger)
                center.add(request) { (error) in
                    if error != nil {
                        print("Something went wrong")
                    }
                }
            }
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmClocks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! ClockTableViewCell
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        cell.backgroundColor = .black
        let alarmSwitch: UISwitch = {
            let alarmS = UISwitch()
            alarmS.isOn = alarmClocks[indexPath.row].isActive
            alarmS.addTarget(self, action: #selector(alarmSwitchChange), for: .valueChanged)
            alarmS.tag = indexPath.row
            return alarmS
        }()
        cell.accessoryView = alarmSwitch
        cell.timeLabel.text = dateFormatter.string(from: alarmClocks[indexPath.row].time)
        cell.detailLabel.text = alarmClocks[indexPath.row].label
        if alarmSwitch.isOn {
            cell.timeLabel.textColor = .white
            cell.detailLabel.textColor = .white
            setupNotification(title: cell.detailLabel.text!, identifier: "\(indexPath.row)", date: alarmClocks[indexPath.row].time, repeated: alarmClocks[indexPath.row].repeated, sound: alarmClocks[indexPath.row].sound)
        } else {
            cell.timeLabel.textColor = .gray
            cell.detailLabel.textColor = .gray
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if alarmClocks[indexPath.row].repeated.isEmpty {
                let identifier = "\(indexPath.row)"
                center.removePendingNotificationRequests(withIdentifiers: [identifier])
            } else {
                for i in 0..<alarmClocks[indexPath.row].repeated.count {
                    var identifier = "\(indexPath.row)"
                    identifier.append(contentsOf: "\(alarmClocks[indexPath.row].repeated[i])")
                    center.removePendingNotificationRequests(withIdentifiers: [identifier])
                }
            }
            alarmClocks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
}
