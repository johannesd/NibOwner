//
//  UICollectionView+NibOwner.swift
//  NibOwner
//
//  Created by Johannes Dörr on 05.10.17.
//  Copyright © 2017 Johannes Dörr. All rights reserved.
//

import Foundation

import UIKit

extension UICollectionView {
    open func register<Class: Any>(_ Class: Class.Type, forCellWithReuseIdentifier reuseIdentifier: String) where Class: UICollectionViewCell & NibOwner {
        self.register(UINib(nibName: Class.nibName, bundle: Bundle(for: Class)), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    open func register<Class: Any>(_ Class: Class.Type, forSupplementaryViewOfKind kind: String, withReuseIdentifier reuseIdentifier: String) where Class: UICollectionReusableView & NibOwner {
        self.register(UINib(nibName: Class.nibName, bundle: Bundle(for: Class)), forSupplementaryViewOfKind: kind, withReuseIdentifier: reuseIdentifier)
    }
}
