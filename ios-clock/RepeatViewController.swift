//
//  RepeatViewController.swift
//  Clock
//
//  Created by 桑染 on 2020-05-29.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

class RepeatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let days = ["Every Sunday", "Every Monday", "Every Tuesday" ,"Every Wednsday", "Every Thursday", "Every Friday", "Every Saturday"]
    
    var weekdays = [Int](repeating: -1, count: 7)
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    typealias completionHandler = ([Int]) -> Void
    var completion: completionHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Repeat"
        tableView.allowsMultipleSelection = true
        view.addSubview(tableView)
        view.backgroundColor = .black
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        tableView.backgroundColor = .black
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = days[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .darkGray
        if weekdays[indexPath.row] == 0 {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            cell.selectionStyle = .none
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        weekdays[indexPath.row] = 0
        cell?.accessoryType = .checkmark
        cell?.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        weekdays[indexPath.row] = -1
        cell?.accessoryType = .none
    }
    
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        let completionBlock = completion
        let repeatDays = weekdays
        completionBlock?(repeatDays)
        navigationController?.popViewController(animated: true)
    }
}
