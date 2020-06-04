//
//  SoundViewController.swift
//  Clock
//
//  Created by 桑染 on 2020-06-03.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var soundName = ""
    
    var player: AVAudioPlayer?
    
    let soundList = ["despacito", "circuit", "romatic", "night", "crystal", "newMessage", "message", "ringingTone", "oldPhone", "trap",]
    
    typealias completionHandler = (String) -> Void
    var completion: completionHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Sound"
        let titleAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        view.backgroundColor = .black
        view.addSubview(tableView)
        tableView.backgroundColor = .black
        tableView.rowHeight = 40
        tableView.register(AddAlarmClockTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.register(SoundTableViewCell.self, forCellReuseIdentifier: "soundViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        let completionBlock = completion
        let label = soundName
        completionBlock?(label)
        navigationController?.popViewController(animated: true)
    }
    
    func playSound(indexPath: IndexPath) {
        guard let url = Bundle.main.url(forResource: "\(soundList[indexPath.row])", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "RINGTONES"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        footerView.backgroundColor = .black
        return footerView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .gray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 10
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! AddAlarmClockTableViewCell
            cell.nameLabel.text = "Vibration"
            cell.optionLabel.text = "Alert"
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "soundViewCell", for: indexPath) as! SoundTableViewCell
            cell.soundLabel.text = soundList[indexPath.row]
            cell.soundLabel.textColor = .white
            cell.tintColor = .white
            cell.backgroundColor = .darkGray
            cell.imageView?.image = UIImage(named: "checkMark")?.withRenderingMode(.alwaysTemplate)
            cell.imageView?.tintColor = .orange
            if soundList[indexPath.row] == soundName {
                cell.imageView?.isHidden = false
                cell.isSelected = true
            } else {
                cell.imageView?.isHidden = true
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SoundTableViewCell
        soundName = cell.soundLabel.text!
        cell.selectionStyle = .none
        cell.imageView?.isHidden = false
        playSound(indexPath: indexPath)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SoundTableViewCell
        cell.imageView?.isHidden = true
    }
}
