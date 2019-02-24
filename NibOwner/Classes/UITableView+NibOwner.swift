//
//  UITableView+NibOwner.swift
//  NibOwner
//
//  Created by Johannes Dörr on 05.10.17.
//  Copyright © 2017 Johannes Dörr. All rights reserved.
//

import Foundation

extension UITableView {
    open func register<Class: Any>(_ Class: Class.Type, forCellReuseIdentifier reuseIdentifier: String) where Class: UITableViewCell & NibOwner {
        self.register(UINib(nibName: Class.nibName, bundle: Bundle(for: Class)), forCellReuseIdentifier: reuseIdentifier)
    }
}
