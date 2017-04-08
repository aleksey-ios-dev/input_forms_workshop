//
//  Application Validators.swift
//  Workshop
//
//  Created by Aleksey on 07.04.17.
//  Copyright © 2017 Jack Lapin. All rights reserved.
//

import Foundation

struct Validators {
    
    static let name = !shorterThan(3) && !longerThan(20)
    static let age = greaterThan(18)
    
    
}
