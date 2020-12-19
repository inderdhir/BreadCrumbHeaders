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
        NSLayoutConstraint.activate([
            headers.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            headers.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            headers.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            headers.heightAnchor.constraint(equalToConstant: 35)
        ])

        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.widthAnchor.constraint(equalToConstant: 200),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }

    @objc func nextTapped() {
        let nextIndex = headers.selectedIndex + 1
        if nextIndex < headers.count {
            headers.selectedIndex = nextIndex
        }
    }
}

