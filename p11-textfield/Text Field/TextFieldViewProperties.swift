//
//  TextFieldViewProperties.swift
//  p11-textfield
//
//  Created by Arjin Reyes on 4/2/19.
//  Copyright © 2019 Arjin Reyes. All rights reserved.
//

import Foundation
import UIKit

class TextFieldViewProperties {
    
    var label: String = "Label"
    var helpText: String = "Please use active email address"
    
    var defaultLabelColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    var activeLabelColor = UIColor(red: 0.17, green: 0, blue: 0.88, alpha: 1)
    var bottomBorderColor: UIColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
    var clearButtonColor = UIColor(red: 0.51, green: 0.6, blue: 0.63, alpha: 1)
    var helpTextColor = UIColor(red: 0.51, green: 0.6, blue: 0.63, alpha: 1)
    
    var inputValidIcon = UIImage(named: "icon-green-check")
    var errorIcon = UIImage(named: "icon-error")
    var clearButtonLabel = "CLEAR"
    
    
    
}
