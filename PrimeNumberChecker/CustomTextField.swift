//
//  CustomTextField.swift
//  PrimeNumberChecker
//
//  Created by Adam Thuvesen on 2016-05-13.
//  Copyright © 2016 Adam Thuvesen. All rights reserved.
//

import Foundation
import UIKit

class MyCustomTextField: UITextField {
    required init(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)!
        self.layer.cornerRadius = 25
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.layer.borderWidth = 1.5
       // self.layer.opacity = 0.3
        self.backgroundColor = UIColor.lightGrayColor()
        self.textColor = UIColor.whiteColor()
        self.textAlignment = .Center
        self.tintColor = UIColor.whiteColor()
        self.keyboardAppearance = .Dark
        self.keyboardType = .NumberPad
        self.clearButtonMode = .WhileEditing
        self.placeholder = "Enter a number"
        
    }
}