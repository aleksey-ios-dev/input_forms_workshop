//
//  InputFormBuilder.swift
//  Workshop
//
//  Created by Roman Kyrylenko on 4/8/17.
//  Copyright © 2017 Jack Lapin. All rights reserved.
//

import Foundation

class InputFormBuilder {
    
    typealias InputFormContents = (fields: [InputField], defaultsAppliers: [ChangesApplier], changesAppliers: [ChangesApplier])
    
    func build() -> InputForm {
        let form = InputForm()
        form.accept(self)
        
        return form
    }
    
    func createContents() -> InputFormContents {
        fatalError("Should be overridden!")
    }
    
}

class UserInfoFormBuilder: InputFormBuilder {
    
    override func createContents() -> InputFormBuilder.InputFormContents {
        var defaultsAppliers = [ChangesApplier]()
        var changesAppliers = [ChangesApplier]()
        
        let firstName = TextInputField()
        firstName.title = "First Name"
        firstName.validator = Validators.name
        defaultsAppliers.append { firstName.applyValue($0.firstName) }
        changesAppliers.append { $0.firstName = firstName.value.value }
        
        let lastName = TextInputField()
        lastName.title = "Last Name"
        lastName.validator = Validators.name
        defaultsAppliers.append { lastName.applyValue($0.lastName) }
        changesAppliers.append { $0.lastName = lastName.value.value }
        
        let age = IntInputField()
        age.title = "Age"
        age.validator = Validators.age
        age.minimum = 1
        age.maximum = 100
        defaultsAppliers.append { age.applyValue($0.age) }
        changesAppliers.append { $0.age = age.value.value }
        
        let numberOfKids = IntInputField()
        numberOfKids.title = "Number of kids"
        numberOfKids.validator = greaterThan(0)
        numberOfKids.minimum = 0
        numberOfKids.maximum = 6
        numberOfKids.preferredStyle = .stepper
        defaultsAppliers.append { numberOfKids.applyValue($0.numberOfKids) }
        changesAppliers.append { $0.numberOfKids = numberOfKids.value.value }
        
        let inputFields = [firstName, numberOfKids, lastName, age]
        
        return (inputFields, defaultsAppliers, changesAppliers)
    }
    
}

class ShortUserInfoBuilder: InputFormBuilder {
    
    override func createContents() -> InputFormBuilder.InputFormContents {
        var defaultsAppliers = [ChangesApplier]()
        var changesAppliers = [ChangesApplier]()
        
        let grade = TextInputField()
        grade.title = "Grade"
        grade.validator = Validators.name
        defaultsAppliers.append { grade.applyValue($0.lastName) }
        changesAppliers.append { $0.lastName = grade.value.value }
        
        let height = IntInputField()
        height.title = "Height"
        height.validator = greaterThan(100)
        height.minimum = 50
        height.maximum = 230
        defaultsAppliers.append { height.applyValue($0.age) }
        changesAppliers.append { $0.age = height.value.value }
        
        let inputFields = [grade, height]
        
        return (inputFields, defaultsAppliers, changesAppliers)
    }
    
}
