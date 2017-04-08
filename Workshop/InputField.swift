//
//  InputField.swift
//  Workshop
//
//  Created by Jack Lapin on 3/11/17.
//  Copyright © 2017 Jack Lapin. All rights reserved.
//

import Foundation


class InputField {

    var title = ""
    var isValid = Observable(true)
    var didChange: Pipe<Void>!
    
}

class TextInputField: InputField {
    
    let value = Observable("")
    var validator = Validator<String> { _ in true }

    override init() {
        super.init()
        
        isValid = value.map { self.validator.check($0) }.observable()
        didChange = value.void()
    }
    
    func applyValue(_ value: String) {
        self.value.value = value
    }
}

class IntInputField: InputField {
    
    enum Style {
        case stepper, slider
    }
    
    let value = Observable(0)
    var validator = Validator<Int> { _ in true }
    var minimum = 0
    var maximum = 100
    var preferredStyle: Style = .slider
    
    override init() {
        super.init()
        
        isValid = value.map { self.validator.check($0) }.observable()
        didChange = value.void()
    }
    
    func applyValue(_ value: Int) {
        self.value.value = value
    }
}
