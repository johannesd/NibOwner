//
//  ExampleCell.swift
//  NibOwner_Example
//
//  Created by Johannes Dörr on 22.12.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import NibOwner

class ExampleCell: UITableViewCell, NibOwner {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var innerView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Additional construction code. Implementing this initializer, even if it only calls super.init?(coder:),
        // hides all other initializers, so that this class can only be initialized using fromNib().
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Make changes to subviews
    }
    
}
