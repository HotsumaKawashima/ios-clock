//
//  AddAlarmClockViewController.swift
//  Clock
//
//  Created by 桑染 on 2020-05-29.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

protocol AddAlarmClockViewControllerDelegate: class {
    func add(alarm: Clock)
}

class AddAlarmClockViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
    
    let options = ["Repeat", "Label", "Sound"]
    let choices = ["Never", "Label", "Radar"]
    var weekdays = [Int](repeating: -1, count: 7)
    
    weak var delegate: AddAlarmClockViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Alarm"
        let titleAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        navigationItem.largeTitleDisplayMode = .never
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveAlarm))
        navigationItem.rightBarButtonItem = saveButton
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.register(AddAlarmClockTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        
        view.addSubview(timePicker)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            timePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 20),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300)
        ])
        
    }
    
    @objc func saveAlarm(_ sender: UIBarButtonItem) {
        let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! AddAlarmClockTableViewCell
        let label = cell.optionLabel.text!
        var repeated = [Int]()
        for i in 0..<7 {
            if weekdays[i] == 0 {
                repeated.append(i+1)
            }
        }
        let clock = Clock(time: timePicker.date, repeated: repeated, label: label, isActive: true)
        self.delegate?.add(alarm: clock)
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        }
        cell.isSelected = false
    }
}
