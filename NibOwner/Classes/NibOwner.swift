//
//  NibOwner.swift
//  NibOwner
//
//  Created by Johannes Dörr on 05.10.17.
//  Copyright © 2017 Johannes Dörr. All rights reserved.
//

import UIKit

/**
 An object (typically a UIView subclass) that can be decoded using a nib file.
 */
public protocol NibOwner: class {
    static var nibName: String { get }
}

extension NibOwner {
    public static var nibName: String {
        return String(describing: self)
    }
    
    /**
     Creates an instance of the view using its NIB file.
     Parameter owner: The instance to use for connecting outlets. Must be of the class that is set as File Owner in the NIB.
     */
    public static func fromNib(owner: Any? = nil) -> Self? {
        let nib = Bundle(for: Self.self).loadNibNamed(nibName, owner: owner, options: nil)
        return nib?.first as? Self
    }
}
