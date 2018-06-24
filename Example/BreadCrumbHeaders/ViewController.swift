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

    private let headers = BreadcrumbHeaders.initWithHeaders(
        ["One".uppercased(), "Two".uppercased(), "Three".uppercased()]
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(headers)
        headers.translatesAutoresizingMaskIntoConstraints = false
        headers.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        headers.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        headers.topAnchor.constraint(
            equalTo: view.topAnchor,
            constant: 50).isActive = true
        headers.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

