//
//  ViewController.swift
//  Workshop
//
//  Created by Jack Lapin on 3/11/17.
//  Copyright © 2017 Jack Lapin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var form = InputForm()

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var saveButton: UIButton!
    
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
    }
    
    @IBAction private func save(_ sender: AnyObject?) {
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepperCell", for: indexPath)
        
        return cell
    }
    
}
