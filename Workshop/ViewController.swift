//
//  ViewController.swift
//  Workshop
//
//  Created by Jack Lapin on 3/11/17.
//  Copyright © 2017 Jack Lapin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let form = ShortUserInfoBuilder().build()
    
    private let user: User = {
        $0.firstName = "Elon"
        $0.lastName = "Musk"
        $0.age = 45
        $0.numberOfKids = 3
        
        return $0
    }(User())

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.rowHeight = 90.0
        
        let registerNibForCellClass: (UITableViewCell.Type) -> Void = {
            self.tableView.register(UINib(nibName: String(describing: $0), bundle: nil),
                                    forCellReuseIdentifier: String(describing: $0))
        }
        
        registerNibForCellClass(TextCell.self)
        registerNibForCellClass(SliderCell.self)
        registerNibForCellClass(StepperCell.self)
        
        (form.isValid && form.hasChanges).bind(toKeyPath: #keyPath(UIButton.enabled), of: saveButton)
        
        form.prefill(with: user)
        form.hasChanges.bind(toKeyPath: #keyPath(UIButton.enabled), of: resetButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        form.startNotifyingAboutChanges()
    }
    
    @IBAction private func save(_ sender: AnyObject?) {
        form.fill(user)
    }
    
    @IBAction private func reset(_ sender: AnyObject?) {
        form.prefill(with: user)
    }
    
    fileprivate func classForCell(at indexPath: IndexPath) -> UITableViewCell.Type {
        switch form.inputFields[indexPath.row] {
            
        case is TextInputField:
            return TextCell.self
            
        case let field as IntInputField:
            switch field.preferredStyle {
            case .slider:
                return SliderCell.self
                
            case .stepper:
                return StepperCell.self
            }
            
        default:
            fatalError("Undefined type")
            
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return form.inputFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = String(describing: classForCell(at: indexPath))
        let cell = tableView.dequeueReusableCell(withIdentifier: type, for: indexPath)
        (cell as? InputFieldDisplaying)?.connect(to: form.inputFields[indexPath.row])
        
        return cell
    }
    
}
