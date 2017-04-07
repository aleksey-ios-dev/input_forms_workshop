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
    var isValid = Observable(false)
    
}

class TextInputField: InputField {
    let value = Observable("")
    var validationRule: ((String) -> Bool) = { _ in return true }

    override init() {
        super.init()
        value.subscribeNext { (nextValue) in
            self.isValid.value = self.validationRule(nextValue)
        }
    }
}

class IntInputField: InputField {
    let value = Observable(0)
    var validationRule: ((Int) -> Bool) = { _ in return true }

    override init() {
        super.init()
        value.subscribeNext { (nextValue) in
            self.isValid.value = self.validationRule(nextValue)
        }
    }
}
