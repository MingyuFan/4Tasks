//
//  GridViewController.swift
//  4Tasks
//
//  Created by MingyuFan on 3/31/17.
//  Copyright © 2017 MingyuFan. All rights reserved.
//

import UIKit
import EventKit

class GridViewController: UIViewController {
    var taskStore: TaskStore!
    var eventStore: EKEventStore!
    
    var gridZero: GridZero!
    var gridOne: GridOne!
    var gridTwo: GridTwo!
    var gridThree: GridThree!
    
    //pass taskStore to sub GridViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
                case "SegueZero":
                gridZero = segue.destination as! GridZero
                gridZero.taskStore = taskStore
                gridZero.eventStore = eventStore
                case "SegueOne":
                gridOne = segue.destination as! GridOne
                gridOne.taskStore = taskStore
                gridOne.eventStore = eventStore
                case "SegueTwo":
                gridTwo = segue.destination as! GridTwo
                gridTwo.taskStore = taskStore
                gridTwo.eventStore = eventStore
                case "SegueThree":
                gridThree = segue.destination as! GridThree
                gridThree.taskStore = taskStore
                gridThree.eventStore = eventStore
            default:
                break
            }
        }
    }
    


}



class GridZero: UITableViewController {
    var taskStore: TaskStore!
    var eventStore: EKEventStore!
    //return row in section  REQUIRED
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskStore.allTasks[0].count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "gridSegueZero"?:
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.taskStore = taskStore
            detailViewController.eventStore = eventStore
                if let row = tableView.indexPathForSelectedRow?.row {
                    detailViewController.task = taskStore.allTasks[0][row]
                }
            
        default:
            break
        }
    }
    
    //display row content  REQUIRED
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GridCellZero", for: indexPath) as! GridCellZero
        let task = taskStore.allTasks[0][indexPath.row]
        cell.TaskName.text = task.name
        return cell
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let defaults = UserDefaults.standard
        
        if(defaults.object(forKey: "gridSwitch") != nil) {
            if(defaults.bool(forKey: "gridSwitch")) {
                return "Ugt and Impt"
            } else {
                return nil
            }
        }
        return nil
    }
}

class GridOne: UITableViewController {
    var taskStore: TaskStore!
    var eventStore: EKEventStore!
    //return row in section  REQUIRED
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskStore.allTasks[1].count
    }
    
    //display row content  REQUIRED
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GridCellOne", for: indexPath) as! GridCellOne
        let task = taskStore.allTasks[1][indexPath.row]
        cell.TaskName.text = task.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "gridSegueOne"?:
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.taskStore = taskStore
            detailViewController.eventStore = eventStore
            if let row = tableView.indexPathForSelectedRow?.row {
                detailViewController.task = taskStore.allTasks[1][row]
            }
            
        default:
            break
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    //show and hide section header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let defaults = UserDefaults.standard
        
        if(defaults.object(forKey: "gridSwitch") != nil) {
            if(defaults.bool(forKey: "gridSwitch")) {
                return "Not Ugt But Impt"
            } else {
                return nil
            }
        }
        return nil
    }
}

class GridTwo: UITableViewController {
    var taskStore: TaskStore!
    var eventStore: EKEventStore!
    //return row in section  REQUIRED
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskStore.allTasks[2].count
    }
    
    //display row content  REQUIRED
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GridCellTwo", for: indexPath) as! GridCellTwo
        let task = taskStore.allTasks[2][indexPath.row]
        cell.TaskName.text = task.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "gridSegueTwo"?:
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.taskStore = taskStore
            detailViewController.eventStore = eventStore
            if let row = tableView.indexPathForSelectedRow?.row {
                detailViewController.task = taskStore.allTasks[2][row]
            }
            
        default:
            break
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    //show and hide section header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let defaults = UserDefaults.standard
        
        if(defaults.object(forKey: "gridSwitch") != nil) {
            if(defaults.bool(forKey: "gridSwitch")) {
                return "Ugt Not Impt"
            } else {
                return nil
            }
        }
        return nil
    }
}

class GridThree: UITableViewController {
    var taskStore: TaskStore!
    var eventStore: EKEventStore!
    //return row in section  REQUIRED
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskStore.allTasks[3].count
    }
    
    //display row content  REQUIRED
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GridCellThree", for: indexPath) as! GridCellThree
        let task = taskStore.allTasks[3][indexPath.row]
        cell.TaskName.text = task.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "gridSegueThree"?:
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.taskStore = taskStore
            detailViewController.eventStore = eventStore
            if let row = tableView.indexPathForSelectedRow?.row {
                detailViewController.task = taskStore.allTasks[3][row]
            }
            
        default:
            break
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    //show and hide section header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let defaults = UserDefaults.standard
        
        if(defaults.object(forKey: "gridSwitch") != nil) {
            if(defaults.bool(forKey: "gridSwitch")) {
                return "Not Ugt Not Impt"
            } else {
                return nil
            }
        }
        return nil
    }
}
