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
}
