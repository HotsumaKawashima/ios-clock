//
//  ClockTableViewCell.swift
//  Clock
//
//  Created by 桑染 on 2020-05-28.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

class ClockTableViewCell: UITableViewCell {

    let timeLabel: UILabel = {
        let tl = UILabel()
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.font = tl.font.withSize(50)
        tl.textColor = .white
        return tl
    }()
    
    let detailLabel: UILabel = {
        let dl = UILabel()
        dl.translatesAutoresizingMaskIntoConstraints = false
        dl.font = dl.font.withSize(20)
        dl.textColor = .white
        return dl
    }()
    
//    let alarmSwith: UISwitch = {
//        let alarms = UISwitch()
//        alarms.translatesAutoresizingMaskIntoConstraints = false
//        alarms.isOn = true
//        return alarms
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(timeLabel)
        contentView.addSubview(detailLabel)
//        contentView.addSubview(alarmSwith)
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
//            alarmSwith.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            alarmSwith.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
