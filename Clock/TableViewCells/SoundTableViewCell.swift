//
//  SoundTableViewCell.swift
//  Clock
//
//  Created by 桑染 on 2020-06-03.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

class SoundTableViewCell: UITableViewCell {

    let soundImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let soundLabel: UILabel = {
        let sl = UILabel()
        sl.translatesAutoresizingMaskIntoConstraints = false
        return sl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(soundImageView)
        contentView.addSubview(soundLabel)
        
        NSLayoutConstraint.activate([
            soundImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            soundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            soundLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            soundLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 70)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
