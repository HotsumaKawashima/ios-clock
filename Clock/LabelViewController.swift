//
//  LabelViewController.swift
//  Clock
//
//  Created by 桑染 on 2020-05-30.
//  Copyright © 2020 Rick. All rights reserved.
//

import UIKit

class LabelViewController: UIViewController {
    
    let labelTextField: UITextField = {
        let ltf = UITextField()
        ltf.translatesAutoresizingMaskIntoConstraints = false
        ltf.backgroundColor = .darkGray
        ltf.textColor = .white
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 2))
        ltf.leftView =  leftView
        ltf.leftViewMode = .always
        return ltf
    }()
    
    typealias completionHandler = (String) -> Void
    var completion: completionHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Label"
        let titleAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = titleAttributes
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        view.addSubview(labelTextField)
        labelTextField.becomeFirstResponder()
        
        NSLayoutConstraint.activate([
            labelTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            labelTextField.widthAnchor.constraint(equalTo: view.widthAnchor),
            labelTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        let completionBlock = completion
        let label = labelTextField.text!
        completionBlock?(label)
        navigationController?.popViewController(animated: true)
        
    }

}
