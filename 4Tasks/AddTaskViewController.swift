//
//  AddTaskViewController.swift
//  4Tasks
//
//  Created by MingyuFan on 4/1/17.
//  Copyright © 2017 MingyuFan. All rights reserved.
//

import UIKit
class AddTaskViewController: UIViewController {
    var taskStore: TaskStore!
    @IBOutlet var Save: UIBarButtonItem!
    
    var priority: Priority?
    var TaskName: String?
    var Detail: String?
    
    //buttons
    @IBOutlet var UI: UIButton!
    @IBOutlet var NUI: UIButton!
    @IBOutlet var UNI: UIButton!
    @IBOutlet var NUNI: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationItem.title = "New Task"
    }
    //create new task and save it, return to previous view
    @IBAction func SaveNewTask(_ sender: Any) {
        if let name = TaskName {
            if let pri = priority {
               taskStore.createTask(taskname: name, taskPriority: pri)
            }
        }
    }
    
    @IBAction func setTask(_ sender: UITextField) {
        if let text = sender.text {
            TaskName = text
        }
    }
    
    @IBAction func inputDetail(_ sender: UITextField) {
        if let text = sender.text {
            Detail = text
        }
    }

    @IBAction func touchUIButton(_ sender: UIButton) {
        priority = Priority.UI
    }

    @IBAction func touchNUIButton(_ sender: UIButton) {
        priority = Priority.NUI
    }
    
    @IBAction func touchUNIButton(_ sender: UIButton) {
        priority = Priority.UNI
    }
    @IBAction func touchNUNIButton(_ sender: UIButton) {
        priority = Priority.NUNI
        
    }
}
