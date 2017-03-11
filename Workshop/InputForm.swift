//
//  InputForm.swift
//  Workshop
//
//  Created by Jack Lapin on 3/11/17.
//  Copyright © 2017 Jack Lapin. All rights reserved.
//

import Foundation

protocol InputFormValidityDelegate: class {
    
    func inputForm(_ form: InputForm, didUpdateValidity to: Bool) -> Void
    
}

class InputForm {
    
    weak var delegate: InputFormValidityDelegate?
    
    var inputFields = [DisplayableAsInputField]()
    
    var isValid = false
    
    func refreshValidityState() {
        isValid = inputFields.map { $0.isValid }.reduce(true) { sum, element in sum && element }
        delegate?.inputForm(self, didUpdateValidity: isValid)
    }
    
    init() {
        let firstName = InputField("")
        firstName.validationRule = { !$0.isEmpty }

        let lastName = InputField("")
        lastName.validationRule = { !$0.isEmpty }

        let age = InputField(0)
        age.validationRule = { $0 > 16 }
        
        inputFields = [firstName, lastName, age]
        
        let didUpdateValidity: ((Bool) -> Void) = { [weak self] _ in
            self?.refreshValidityState()
        }
        
        inputFields.forEach { $0.didUpdateValidity = didUpdateValidity }
    }
    
}

















