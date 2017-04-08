//
//  InputForm.swift
//  Workshop
//
//  Created by Jack Lapin on 3/11/17.
//  Copyright © 2017 Jack Lapin. All rights reserved.
//

import Foundation

typealias ChangesApplier = (User) -> Void

class InputForm {
    
    private(set) var inputFields = [InputField]()
    private(set) var isValid: Observable<Bool>!
    private(set) var hasChanges = Observable(false)
    private var defaultsAppliers = [ChangesApplier]()
    private var changesAppliers = [ChangesApplier]()
    
    func fill(_ user: User) {
        changesAppliers.forEach { $0(user) }
    }
    
    func prefill(with user: User) {
        defaultsAppliers.forEach { $0(user) }
    }
    
    func startNotifyingAboutChanges() {
        Signals.merge(inputFields.map { $0.didChange }).map { true }.bind(to: hasChanges)
    }
    
    func accept(_ builder: InputFormBuilder) {
        let contents = builder.createContents()
        inputFields = contents.fields
        defaultsAppliers = contents.defaultsAppliers
        changesAppliers = contents.changesAppliers
        
        let resetChanges: ChangesApplier = { [weak self] _ in self?.hasChanges.value = false }
        changesAppliers.append(resetChanges)
        defaultsAppliers.append(resetChanges)
        
        isValid = inputFields.map { $0.isValid }.reduce(Observable(true), &&).observable()
    }
    
}
