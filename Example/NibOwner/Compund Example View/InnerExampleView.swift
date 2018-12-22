//
//  InnerExampleView.swift
//  NibOwner_Example
//
//  Created by Johannes Dörr on 23.12.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import NibOwner

internal class InnerExampleView: UIView, NibOwner {
    
    internal required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
