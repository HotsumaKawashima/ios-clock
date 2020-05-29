//
//  AddAlarmViewController.swift
//  Clock
//
//  Created by 桑染 on 2020-05-28.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

protocol AddAlarmViewControllerDelegate: class {
    func add(alarm: Clock)
}

class AddAlarmViewController: UIViewController {
    
    let timePicker: UIDatePicker = {
        let tp = UIDatePicker()
        tp.translatesAutoresizingMaskIntoConstraints = false
        tp.datePickerMode = .time
        tp.setValue(UIColor.white, forKey: "textColor")
        return tp
    }()
    
    let repeatView: UIView = {
        let rv = UIView()
        rv.translatesAutoresizingMaskIntoConstraints = false
        rv.backgroundColor = .darkGray
        rv.layer.borderWidth = 1
        rv.layer.borderColor = UIColor.gray.cgColor
        return rv
    }()
    
    let repeatLabel: UILabel = {
        let rl = UILabel()
        rl.translatesAutoresizingMaskIntoConstraints = false
        rl.text = "Repeat"
        rl.font = rl.font.withSize(20)
        rl.textColor = .white
        return rl
    }()
    
    let repeatOptionLabel: UILabel = {
        let rol = UILabel()
        rol.translatesAutoresizingMaskIntoConstraints = false
        rol.text = "Never >"
        rol.font = rol.font.withSize(20)
        rol.textColor = .lightGray
        return rol
    }()
    
    let labelView: UIView = {
        let lv = UIView()
        lv.translatesAutoresizingMaskIntoConstraints = false
        lv.backgroundColor = .darkGray
        lv.layer.borderWidth = 1
        lv.layer.borderColor = UIColor.gray.cgColor
        return lv
    }()
    
    let labelLabel: UILabel = {
        let ll = UILabel()
        ll.translatesAutoresizingMaskIntoConstraints = false
        ll.text = "Label"
        ll.font = ll.font.withSize(20)
        ll.textColor = .white
        return ll
    }()
    
    let labelOptionLabel: UILabel = {
        let lol = UILabel()
        lol.translatesAutoresizingMaskIntoConstraints = false
        lol.text = "Alarm >"
        lol.font = lol.font.withSize(20)
        lol.textColor = .lightGray
        return lol
    }()
    
    let soundView: UIView = {
        let sv = UIView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .darkGray
        sv.layer.borderWidth = 1
        sv.layer.borderColor = UIColor.gray.cgColor
        return sv
    }()
    
    let soundLabel: UILabel = {
        let sl = UILabel()
        sl.translatesAutoresizingMaskIntoConstraints = false
        sl.text = "Sound"
        sl.font = sl.font.withSize(20)
        sl.textColor = .white
        return sl
    }()
    
    let soundtOptionLabel: UILabel = {
        let sol = UILabel()
        sol.translatesAutoresizingMaskIntoConstraints = false
        sol.text = "Radar >"
        sol.font = sol.font.withSize(20)
        sol.textColor = .lightGray
        return sol
    }()
    
    weak var delegate: AddAlarmViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Alarm"
        let titleAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        navigationItem.largeTitleDisplayMode = .never
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveAlarm))
        navigationItem.rightBarButtonItem = saveButton
        
        repeatView.addSubview(repeatLabel)
        repeatView.addSubview(repeatOptionLabel)
        
        labelView.addSubview(labelLabel)
        labelView.addSubview(labelOptionLabel)
        
        soundView.addSubview(soundLabel)
        soundView.addSubview(soundtOptionLabel)
        
        view.addSubview(timePicker)
        view.addSubview(repeatView)
        view.addSubview(labelView)
        view.addSubview(soundView)
        
        NSLayoutConstraint.activate([
            timePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            repeatView.widthAnchor.constraint(equalTo: view.widthAnchor),
            repeatView.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 20),
            repeatView.heightAnchor.constraint(equalToConstant: 50),
            
            labelView.widthAnchor.constraint(equalTo: view.widthAnchor),
            labelView.topAnchor.constraint(equalTo: repeatView.bottomAnchor),
            labelView.heightAnchor.constraint(equalToConstant: 50),
            
            soundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            soundView.topAnchor.constraint(equalTo: labelView.bottomAnchor),
            soundView.heightAnchor.constraint(equalToConstant: 50),
            
            repeatLabel.centerYAnchor.constraint(equalTo: repeatView.centerYAnchor),
            repeatLabel.leadingAnchor.constraint(equalTo: repeatView.leadingAnchor, constant: 5),
            
            labelLabel.centerYAnchor.constraint(equalTo: labelView.centerYAnchor),
            labelLabel.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 5),
            
            soundLabel.centerYAnchor.constraint(equalTo: soundView.centerYAnchor),
            soundLabel.leadingAnchor.constraint(equalTo: soundView.leadingAnchor, constant: 5),
            
            repeatOptionLabel.centerYAnchor.constraint(equalTo: repeatView.centerYAnchor),
            repeatOptionLabel.trailingAnchor.constraint(equalTo: repeatView.trailingAnchor, constant: -5),
            
            labelOptionLabel.centerYAnchor.constraint(equalTo: labelView.centerYAnchor),
            labelOptionLabel.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -5),
            
            soundtOptionLabel.centerYAnchor.constraint(equalTo: soundView.centerYAnchor),
            soundtOptionLabel.trailingAnchor.constraint(equalTo: soundView.trailingAnchor, constant: -5)
        ])
    }
    
    @objc func saveAlarm(_ sender: UIBarButtonItem) {
        var label = labelOptionLabel.text
        label?.removeLast()
        let clock = Clock(time: timePicker.date, repeated: false, label: label!)
        self.delegate?.add(alarm: clock)
        navigationController?.popViewController(animated: true)
    }
}

