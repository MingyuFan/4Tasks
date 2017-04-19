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
    var originalPriority: Priority!  //the task's original priority
    var priority: Priority!   //may be changed by user
    var itemName: String!
    var itemDetail: String?

    @IBOutlet var TaskName: UITextField!
    @IBOutlet var Detail: UITextView!
    @IBOutlet var PriorityButton: UIButton!
    @IBOutlet var DateButton: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPopUp"?:
            let popUpViewController = segue.destination as! ChangePriorityPopUpViewController
            popUpViewController.popUpPriority = priority
        default:
            break
        }
    }

    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Task"
        originalPriority = task.priority
        priority = task.priority
        itemName = task.name
        if let de = task.detail {
            itemDetail = de}
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
    
    @IBAction func changeName(_ sender: UITextField) {
        if let name = sender.text {
            itemName = name
        }
    }

    @IBAction func changePriorityActionSheet(_ sender: UIButton) {
        let title = "Change Priority?"
        let message = "Set Priority to:"
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        let setToUI = UIAlertAction(title: "Urgent and Important", style: .destructive, handler: {
            (action)->Void in
            self.priority = Priority.UI
        })
        ac.addAction(setToUI)
        
        let setToNUI = UIAlertAction(title: "Not Urgent but Important", style: .destructive, handler: {
            (action)->Void in
            self.priority = Priority.NUI
        })
        ac.addAction(setToNUI)
        
        let setToUNI = UIAlertAction(title: "Urgent but Not Important", style: .destructive, handler: {
            (action)->Void in
            self.priority = Priority.UNI
        })
        ac.addAction(setToUNI)
        
        let setToNUNI = UIAlertAction(title: "Not Urgent Not Important", style: .destructive, handler: {
            (action)->Void in
            self.priority = Priority.NUNI
        })
        ac.addAction(setToNUNI)
        present(ac, animated: true,completion: nil)
    }
    
    @IBAction func saveTask(_ sender: UIButton) {
        task.name = itemName
        
        _ = navigationController?.popViewController(animated: true)
    }
}
