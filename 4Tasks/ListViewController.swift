//
//  ListViewController.swift
//  4Tasks
//
//  Created by MingyuFan on 3/26/17.
//  Copyright © 2017 MingyuFan. All rights reserved.
//

//03/27/2017 add MapKit to test UITabBar
import UIKit
import EventKit

class ListViewController: UITableViewController {
    var taskStore: TaskStore!
    var eventStore: EKEventStore!
    //pass data to detail
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "listDetail"?:
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.taskStore = taskStore
            detailViewController.eventStore = eventStore
            if let section = tableView.indexPathForSelectedRow?.section {
                if let row = tableView.indexPathForSelectedRow?.row {
                    detailViewController.task = taskStore.allTasks[section][row]
                }
            }
        default:
            break
        }
    }
    //return row in section  REQUIRED
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskStore.allTasks[section].count
    }
    
    //display row content  REQUIRED
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! ListCell
        let task = taskStore.allTasks[indexPath.section][indexPath.row]
        
        cell.TaskName.text = task.name
        switch indexPath.section {
        case 0:
            cell.contentView.subviews[1].backgroundColor = UIColor.red
        case 1:
            cell.contentView.subviews[1].backgroundColor = UIColor.orange
        case 2:
            cell.contentView.subviews[1].backgroundColor = UIColor.blue
        case 3:
            cell.contentView.subviews[1].backgroundColor = UIColor.green
        default:
            break
        }
        return cell
    }
    //show section header or not
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let defaults = UserDefaults.standard
        
        if(defaults.object(forKey: "listSwitch") != nil ) {
            if(defaults.bool(forKey: "listSwitch")) {
                switch section {
                case 0:
                    if (taskStore.allTasks[0].count==0) {return nil}
                    else {return "Urgent and Important"}
                case 1:
                    if (taskStore.allTasks[1].count==0) {return nil}
                    else {return "Not Urgent but Important"}
                case 2:
                    if (taskStore.allTasks[2].count==0) {return nil}
                    else {return "Urgent but Not Important"}
                case 3:
                    if (taskStore.allTasks[3].count==0) {return nil}
                    else {return "Not Urgent Not Important"}
                default:
                    return nil
                }
            }
        }
        return nil
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

}
