//
//  User.swift
//  Workshop
//
//  Created by Jack Lapin on 3/11/17.
//  Copyright © 2017 Jack Lapin. All rights reserved.
//

import Foundation

class User: CustomDebugStringConvertible {
    
    var firstName = ""
    var lastName = ""
    var age = 0
    var numberOfKids = 0
    
    var debugDescription: String {
        var result = "\(firstName) \(lastName)\n"
        result.append("Age: \(age)\n")
        result.append("Kids: \(numberOfKids)\n")
        
        return result
    }
    
}
