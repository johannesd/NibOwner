//
//  CompoundExampleView.swift
//  NibOwner_Example
//
//  Created by Johannes Dörr on 23.12.18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

@IBDesignable
public class CompoundExampleView: UIView {

    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        insertInnerView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        insertInnerView()
    }
    
    func insertInnerView() {
        if let innerView = InnerExampleView.fromNib(owner: self) {
            addSubview(innerView)
            innerView.translatesAutoresizingMaskIntoConstraints = false
            innerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            innerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            innerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            innerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
    }

}
