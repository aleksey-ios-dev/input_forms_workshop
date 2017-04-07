//
//  InputForm.swift
//  Workshop
//
//  Created by Jack Lapin on 3/11/17.
//  Copyright © 2017 Jack Lapin. All rights reserved.
//

import Foundation

class InputForm {
    
    var inputFields = [InputField]()
    var isValid = Observable(false)

    init() {
        let firstName = TextInputField()
        firstName.validationRule = { !$0.isEmpty }

        let lastName = TextInputField()
        lastName.validationRule = { !$0.isEmpty }

        let age = IntInputField()
        age.validationRule = { $0 > 16 }

        inputFields = [firstName, lastName, age]
        subscribeForFieldsValidity(fields: inputFields)
    }

    func subscribeForFieldsValidity(fields: [InputField]) {
        _ = fields.map { $0.isValid }.reduce(Observable(true)) { (result, current) in
            return result && current
            }.subscribeNext { self.isValid.value = $0 }
    }
    
}
