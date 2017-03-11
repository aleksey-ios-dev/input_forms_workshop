//
//  InputField.swift
//  Workshop
//
//  Created by Jack Lapin on 3/11/17.
//  Copyright © 2017 Jack Lapin. All rights reserved.
//

import Foundation

protocol DisplayableAsInputField: class {
    
    var title: String { get set }
    var isValid: Bool { get }
    var didUpdateValidity: ((Bool) -> Void)? { get set }
    
}

class InputField<T>: DisplayableAsInputField {
    
    var value: T {
        didSet {
            isValid = validationRule(value)
        }
    }
    var title = ""
    var isValid = false {
        didSet {
            didUpdateValidity?(isValid)
        }
    }
    
    var validationRule: ((T) -> Bool) = { _ in return true }
    var didUpdateValidity: ((Bool) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
}
