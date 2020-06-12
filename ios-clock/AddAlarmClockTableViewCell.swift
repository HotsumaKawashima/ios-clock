//
//  AddAlarmClockTableViewCell.swift
//  Clock
//
//  Created by 桑染 on 2020-05-29.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

class AddAlarmClockTableViewCell: UITableViewCell {

    let nameLabel: UILabel = {
        let nl = UILabel()
        nl.translatesAutoresizingMaskIntoConstraints = false
        return nl
    }()
    
    let optionLabel: UILabel = {
        let ol = UILabel()
        ol.translatesAutoresizingMaskIntoConstraints = false
        return ol
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(optionLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            
            optionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            optionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
