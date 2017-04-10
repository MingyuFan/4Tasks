//
//  ChangePriorityPopUpViewController.swift
//  4Tasks
//
//  Created by MingyuFan on 4/10/17.
//  Copyright © 2017 MingyuFan. All rights reserved.
//

import UIKit

class ChangePriorityPopUpViewController: UIViewController {
    var popUpPriority: Priority!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    @IBAction func setToUI(_ sender: UIButton) {
        popUpPriority = Priority.UI
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func setToNUI(_ sender: UIButton) {
        popUpPriority = Priority.NUI
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func setToUNI(_ sender: UIButton) {
        popUpPriority = Priority.UNI
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func setToNUNI(_ sender: UIButton) {
        popUpPriority = Priority.NUNI
        _ = navigationController?.popViewController(animated: true)
    }
}
