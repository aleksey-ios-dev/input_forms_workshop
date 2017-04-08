//
//  StepperCell.swift
//  Workshop
//
//  Created by Aleksey on 07.04.17.
//  Copyright © 2017 Jack Lapin. All rights reserved.
//

import UIKit

class StepperCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var stepper: UIStepper!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var valueLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pool.drain()
    }
    
}

extension StepperCell: InputFieldDisplaying {
    
    func connect(to field: InputField) {
        guard let field = field as? IntInputField else { return }
        
        titleLabel.text = field.title
        stepper.maximumValue = Double(field.maximum)
        stepper.minimumValue = Double(field.minimum)
        stepper.value = Double(field.value.value)
        
        stepper.valueSignal.subscribeNext { field.applyValue(Int($0)) }.putInto(pool)
        field.value.bind(toKeyPath: #keyPath(UIStepper.value), of: stepper).putInto(pool)
        field.value.map { String($0) }.bind(toKeyPath: #keyPath(UILabel.text), of: valueLabel).putInto(pool)
    }
    
}
