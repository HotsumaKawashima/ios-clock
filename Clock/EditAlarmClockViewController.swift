//
//  EditAlarmClockViewController.swift
//  Clock
//
//  Created by 桑染 on 2020-06-04.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

protocol EditAlarmClockViewControllerDelegate: class {
    func edit(alarm: Clock, indexPath: IndexPath)
    func delete(indexPath: IndexPath)
}

class EditAlarmClockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var clock: Clock!
    
    var alarmIndexPath: IndexPath!
    
    let timePicker: UIDatePicker = {
        let tp = UIDatePicker()
        tp.translatesAutoresizingMaskIntoConstraints = false
        tp.datePickerMode = .time
        tp.setValue(UIColor.white, forKey: "textColor")
        return tp
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    weak var delegate: EditAlarmClockViewControllerDelegate?
    
    var options = ["Repeat", "Label", "Sound"]
    var choices = ["Never", "Alarm", "despacito"]
    var weekdays = [Int](repeating: -1, count: 7)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Edit Alarm"
        let titleAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        navigationItem.largeTitleDisplayMode = .never
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveAlarm))
        navigationItem.rightBarButtonItem = saveButton
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelEdit))
        navigationItem.leftBarButtonItem = cancelButton
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.register(AddAlarmClockTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.register(DeleteTableViewCell.self, forCellReuseIdentifier: "deleteCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        
        updateUI()
        
        view.addSubview(timePicker)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            timePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 20),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
    }
    
    func updateUI() {
        
        timePicker.date = clock.time
        
        if clock.repeated.count == 0 {
            choices[0] = "Never"
        } else if clock.repeated.count == 7 {
            choices[0] = "Everyday"
        } else {
            choices[0] = ""
            for i in 0..<clock.repeated.count {
                weekdays[clock.repeated[i] - 1] = 0
            }
            for i in 0..<7 {
                if weekdays[i] == 0 {
                    switch i {
                    case 0:
                        choices[0].append(" Sun")
                    case 1:
                        choices[0].append(" Mon")
                    case 2:
                        choices[0].append(" Tue")
                    case 3:
                        choices[0].append(" Wed")
                    case 4:
                        choices[0].append(" Thu")
                    case 5:
                        choices[0].append(" Fri")
                    case 6:
                        choices[0].append(" Sat")
                    default:
                        return
                    }
                }
            }
        }
        
        choices[1] = clock.label
        
        choices[2] = clock.sound
        
    }
    
    @objc func cancelEdit(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveAlarm(_ sender: UIBarButtonItem) {
        let labelCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! AddAlarmClockTableViewCell
        let label = labelCell.optionLabel.text!
        var repeated = [Int]()
        let soundCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! AddAlarmClockTableViewCell
        let sound = soundCell.optionLabel.text!
        var repeats: Bool
        for i in 0..<7 {
            if weekdays[i] == 0 {
                repeated.append(i+1)
            }
        }
        if !weekdays.contains(0) {
            repeats = false
        } else {
            repeats = true
        }
        let clock = Clock(time: timePicker.date, repeated: repeated, label: label, isActive: true, sound: sound, repeats: repeats)
        self.delegate?.edit(alarm: clock, indexPath: alarmIndexPath)
        navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return options.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerview = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        footerview.backgroundColor = .black
        return footerview
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! AddAlarmClockTableViewCell
            cell.nameLabel.text = options[indexPath.row]
            cell.optionLabel.text = choices[indexPath.row]
            cell.backgroundColor = .darkGray
            cell.nameLabel.textColor = .white
            cell.optionLabel.textColor = .white
            cell.tintColor = .white
            let image = UIImage(named:"disclosureArrow")?.withRenderingMode(.alwaysTemplate)
            let disclosureImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            disclosureImageView.image = image
            cell.accessoryView = disclosureImageView
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "deleteCell", for: indexPath) as! DeleteTableViewCell
            cell.deleteLabel.text = "Delete Alarm"
            cell.backgroundColor = .darkGray
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let cell = tableView.cellForRow(at: indexPath) as! AddAlarmClockTableViewCell
            if indexPath.row == 0 {
                let repeatVC = RepeatViewController()
                
                repeatVC.weekdays = weekdays
                repeatVC.completion = { repeatDays in
                    var optionString = String()
                    if !repeatDays.contains(-1) {
                        optionString.append("Everyday")
                    } else {
                        for i in 0..<7 {
                            if repeatDays[i] == 0 {
                                switch i {
                                case 0:
                                    optionString.append(" Sun")
                                case 1:
                                    optionString.append(" Mon")
                                case 2:
                                    optionString.append(" Tue")
                                case 3:
                                    optionString.append(" Wed")
                                case 4:
                                    optionString.append(" Thu")
                                case 5:
                                    optionString.append(" Fri")
                                case 6:
                                    optionString.append(" Sat")
                                default:
                                    return
                                }
                            }
                        }
                    }
                    self.weekdays = repeatDays
                    if optionString.count > 0 {
                        cell.optionLabel.text = optionString
                    } else {
                        cell.optionLabel.text = "Never"
                    }
                    
                }
                navigationController?.pushViewController(repeatVC, animated: true)
                    
            } else if indexPath.row == 1 {
                let labelVC = LabelViewController()
                labelVC.labelTextField.text = cell.optionLabel.text
                labelVC.completion = { label in
                    cell.optionLabel.text = label
                }
                navigationController?.pushViewController(labelVC, animated: true)
            } else if indexPath.row == 2 {
                let soundVC = SoundViewController()
                soundVC.soundName = cell.optionLabel.text!
                soundVC.completion = { label in
                    if label.isEmpty {
                        cell.optionLabel.text = "despacito"
                    } else {
                        cell.optionLabel.text = label
                    }
                }
                navigationController?.pushViewController(soundVC, animated: true)
            }
            cell.isSelected = false
        } else {
            self.delegate?.delete(indexPath: alarmIndexPath)
            navigationController?.popViewController(animated: true)
        }
    }
}

