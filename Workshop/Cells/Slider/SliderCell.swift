//
//  SliderCell.swift
//  Workshop
//
//  Created by Aleksey on 07.04.17.
//  Copyright © 2017 Jack Lapin. All rights reserved.
//

import UIKit

class SliderCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var slider: UISlider!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var valueLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pool.drain()
    }
    
}

extension SliderCell: InputFieldDisplaying {
    
    func connect(to field: InputField) {
        guard let field = field as? IntInputField else { return }
        
        titleLabel.text = field.title
        slider.maximumValue = Float(field.maximum)
        slider.minimumValue = Float(field.minimum)
        slider.value = Float(field.value.value)
        
        slider.valueSignal.subscribeNext { field.applyValue(Int($0)) }.putInto(pool)
        field.value.bind(toKeyPath: #keyPath(UISlider.value), of: slider).putInto(pool)
        field.value.map { String($0) }.bind(toKeyPath: #keyPath(UILabel.text), of: valueLabel).putInto(pool)
    }
    
}
