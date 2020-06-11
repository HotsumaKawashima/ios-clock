//
//  DeleteTableViewCell.swift
//  Clock
//
//  Created by 桑染 on 2020-06-04.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

class DeleteTableViewCell: UITableViewCell {

    let deleteLabel: UILabel = {
        let dl = UILabel()
        dl.translatesAutoresizingMaskIntoConstraints = false
        dl.textColor = .red
        return dl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(deleteLabel)
        
        NSLayoutConstraint.activate([
            deleteLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            deleteLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
