//
//  ViewController.swift
//  BreadCrumbHeaders
//
//  Created by Inder Dhir on 06/24/2018.
//  Copyright (c) 2018 Inder Dhir. All rights reserved.
//

import UIKit
import BreadCrumbHeaders

class ViewController: UIViewController {

    private let headers = BreadcrumbHeaders(
        headers: ["One".uppercased(), "Two".uppercased(), "Three".uppercased()]
    )

    private let nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.titleLabel?.textColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(headers)
        view.addSubview(nextButton)

        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)

        headers.translatesAutoresizingMaskIntoConstraints = false
        headers.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        headers.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        headers.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        headers.heightAnchor.constraint(equalToConstant: 25).isActive = true

        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }

    @objc func nextTapped() {
        let nextIndex = headers.selectedIndex + 1
        if nextIndex < headers.count {
            headers.selectedIndex = nextIndex
        }
    }
}

