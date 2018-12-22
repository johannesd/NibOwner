//
//  ExampleViewController.swift
//  NibOwner_Example
//
//  Created by Johannes Dörr on 12/22/2018.
//  Copyright (c) 2018 Johannes Dörr. All rights reserved.
//

import UIKit

public class ExampleViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate view and add it as subview from code:
        if let exampleView = ExampleView.fromNib() {
            exampleView.frame = CGRect(x: 20, y: 20, width: 250, height: 250)
            view.addSubview(exampleView)
        }
    }

}

