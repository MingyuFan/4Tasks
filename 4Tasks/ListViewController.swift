//
//  ListViewController.swift
//  4Tasks
//
//  Created by MingyuFan on 3/26/17.
//  Copyright © 2017 MingyuFan. All rights reserved.
//

//03/27/2017 add MapKit to test UITabBar
import UIKit

class ListViewController: UITableViewController {
    var taskStore: TaskStore!
    
    //override func viewDidLoad() {
     //   super.viewDidLoad()
        
    //    let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
     //   let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
    //    tableView.contentInset = insets
     //   tableView.scrollIndicatorInsets = insets
    //}
    //return row in section  REQUIRED
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskStore.allTasks[section].count
    }
    
    //display row content  REQUIRED
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        let task = taskStore.allTasks[indexPath.section][indexPath.row]
        
        cell.TaskName.text = task.name
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
}
