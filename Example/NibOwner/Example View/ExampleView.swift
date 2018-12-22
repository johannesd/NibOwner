//
//  ExampleView.swift
//  NibOwner_Example
//
//  Created by Johannes Dörr on 22.12.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import NibOwner

public class ExampleView: UIView, NibOwner {
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Additional construction code. Implementing this initializer, even if it only calls super.init?(coder:),
        // hides all other initializers, so that this class can only be initialized using fromNib().
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        // Make changes to subviews
    }
    
}
