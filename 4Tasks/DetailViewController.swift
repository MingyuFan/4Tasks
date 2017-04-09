//
//  DetailViewController.swift
//  4Tasks
//
//  Created by MingyuFan on 4/1/17.
//  Copyright © 2017 MingyuFan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var taskStore: TaskStore!
    var task: Task!
    var priority: Priority!
    var itemName: String!
    var itemDetail: String?

    @IBOutlet var TaskName: UITextField!
    @IBOutlet var Detail: UITextView!
    @IBOutlet var PriorityButton: UIButton!
    @IBOutlet var DateButton: UIButton!
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Task"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        TaskName.text = task.name
        if let detail = task.detail {
            Detail.text = detail
        }
        switch task.priority! {
        case Priority.UI: PriorityButton.setTitle("Priority: Urgent and Important", for: .normal)
        case Priority.NUI: PriorityButton.setTitle("Priority: Not Urgent but Important", for: .normal)
        case Priority.NUNI: PriorityButton.setTitle("Priority: Not Urgent Not Important", for: .normal)
        case Priority.UNI: PriorityButton.setTitle("Priority: Urgent but Not Important", for: .normal)
        }
        DateButton.setTitle("Date: \(dateFormatter.string(from: task.dateCreated))", for: .normal)
    }
    
}
