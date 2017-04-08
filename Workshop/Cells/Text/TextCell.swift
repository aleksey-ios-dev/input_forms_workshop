//
//  TextCell.swift
//  Workshop
//
//  Created by Aleksey on 07.04.17.
//  Copyright © 2017 Jack Lapin. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var textField: UITextField!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pool.drain()
    }
    
}

extension TextCell: InputFieldDisplaying {
    
    func connect(to field: InputField) {
        guard let field = field as? TextInputField else { return }
        
        titleLabel.text = field.title
        textField.text = field.value.value
        textField.textSignal.subscribeNext { field.applyValue($0) }.putInto(pool)
        field.value.bind(toKeyPath: #keyPath(UITextField.text), of: textField).putInto(pool)
    }
    
}
