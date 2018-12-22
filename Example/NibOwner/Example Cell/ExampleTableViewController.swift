//
//  ExampleTableViewController.swift
//  NibOwner_Example
//
//  Created by Johannes Dörr on 22.12.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import NibOwner

class ExampleTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // You typically instantiate cells yourselve (which would be possible using `ExampleCell.fromNib()`).
        // Instead, you register the class to the tableView:
        tableView.register(ExampleCell.self, forCellWithReuseIdentifier: "ExampleCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExampleCell", for: indexPath)
        return cell
    }

}
