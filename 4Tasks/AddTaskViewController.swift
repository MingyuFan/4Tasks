//
//  AddTaskViewController.swift
//  4Tasks
//
//  Created by MingyuFan on 4/1/17.
//  Copyright © 2017 MingyuFan. All rights reserved.
//

import UIKit
class AddTaskViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var taskStore: TaskStore!
    @IBOutlet var Save: UIBarButtonItem!
    
    var priority: Priority?
    var TaskName: String?
    var Detail: String?
    

    @IBOutlet var DetailTextView: UITextView!
    //buttons
    @IBOutlet var UI: UIButton!
    @IBOutlet var NUI: UIButton!
    @IBOutlet var UNI: UIButton!
    @IBOutlet var NUNI: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let toolbar = UIToolbar()
        toolbar.bounds = CGRect(x: 0, y: 0, width: 320, height: 50)
        toolbar.sizeToFit()
        toolbar.barStyle = UIBarStyle.default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil), UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(handleDone(sender:)))
        ]
        
        self.DetailTextView.inputAccessoryView = toolbar
        //navigationItem.title = "New Task"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    //create new task and save it, return to previous view
    @IBAction func SaveNewTask(_ sender: Any) {
        if let name = TaskName {
            if let pri = priority {
               let task = taskStore.createTask(taskname: name, taskPriority: pri)
                if let text = DetailTextView.text {
                    Detail = text
                    task.detail = Detail
                }
                _ = navigationController?.popViewController(animated: true)
            } else {
                let message = "Please select Priority"
                let ac = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                ac.addAction(cancelAction)
                present(ac, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func inputTask(_ sender: UITextField) {
        if let text = sender.text {
            TaskName = text
        }
    }

    @IBAction func touchUIButton(_ sender: UIButton) {
        priority = Priority.UI
        UI.backgroundColor = UIColor.lightGray
        NUI.backgroundColor = UIColor.white
        UNI.backgroundColor = UIColor.white
        NUNI.backgroundColor = UIColor.white
    }

    @IBAction func touchNUIButton(_ sender: UIButton) {
        priority = Priority.NUI
        UI.backgroundColor = UIColor.white
        NUI.backgroundColor = UIColor.lightGray
        UNI.backgroundColor = UIColor.white
        NUNI.backgroundColor = UIColor.white
    }
    
    @IBAction func touchUNIButton(_ sender: UIButton) {
        priority = Priority.UNI
        UI.backgroundColor = UIColor.white
        NUI.backgroundColor = UIColor.white
        UNI.backgroundColor = UIColor.lightGray
        NUNI.backgroundColor = UIColor.white
    }
    @IBAction func touchNUNIButton(_ sender: UIButton) {
        priority = Priority.NUNI
        UI.backgroundColor = UIColor.white
        NUI.backgroundColor = UIColor.white
        UNI.backgroundColor = UIColor.white
        NUNI.backgroundColor = UIColor.lightGray
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func handleDone(sender: UIButton) {
        self.DetailTextView.resignFirstResponder()
    }
}
