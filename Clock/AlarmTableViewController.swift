//
//  AlarmTableViewController.swift
//  Clock
//
//  Created by 桑染 on 2020-05-28.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

class AlarmTableViewController: UITableViewController, AddAlarmViewControllerDelegate {
    
    var alarmClocks: [Clock] = []
    
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
    }
    
    func add(alarm: Clock) {
        alarmClocks.append(alarm)
        tableView.reloadData()
    }
    
    @objc func addAlarm(_ sender: UIBarButtonItem) {
        let addVC = AddAlarmViewController()
        addVC.delegate = self
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    @objc func alarmSwitchChange(_ sender: UISwitch) {
        if sender.isOn {
            print("1")
        } else {
            print("2")
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
            alarmS.isOn = true
            alarmS.addTarget(self, action: #selector(alarmSwitchChange), for: .valueChanged)
            return alarmS
        }()
        cell.accessoryView = alarmSwitch
        cell.timeLabel.text = dateFormatter.string(from: alarmClocks[indexPath.row].time)
        cell.detailLabel.text = alarmClocks[indexPath.row].label
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            alarmClocks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
