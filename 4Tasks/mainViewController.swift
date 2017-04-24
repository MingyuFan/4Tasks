//
//  mainViewController.swift
//  4Tasks
//
//  Created by MingyuFan on 3/29/17.
//  Copyright © 2017 MingyuFan. All rights reserved.
//
//  3/29/2017 redesign structure, use container view
//  4/1/2017  main structure done, data transmission done
//  4/2/2017  AddTaskViewController.swift's funcionality done

import UIKit

class mainViewController: UIViewController {
    var taskStore: TaskStore!
    
    @IBOutlet var headerListSwitch: UISwitch!
    @IBOutlet var headerGridSwitch: UISwitch!
    
    @IBOutlet var leadingConstraint: NSLayoutConstraint!
    var menuShowing: Bool = false
    
    @IBOutlet var menuView: UIView!
    
    var containerViewController: UITabBarController!
    var addNewTaskViewController: AddTaskViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if(defaults.object(forKey: "listSwitch") != nil) {
            headerListSwitch.isOn = defaults.bool(forKey: "listSwitch")
        }
        
        if(defaults.object(forKey: "gridSwitch") != nil) {
            headerListSwitch.isOn = defaults.bool(forKey: "gridSwitch")
        }
        
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 6
    }
    let containerSegueName = "containerSegue"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == containerSegueName{
            containerViewController = segue.destination as! UITabBarController
            //pass taskStore to two sub viewControllers
            let listViewController = containerViewController!.viewControllers?[0] as! ListViewController
            let gridViewController = containerViewController!.viewControllers?[1] as! GridViewController
            listViewController.taskStore = taskStore
            gridViewController.taskStore = taskStore
        }
        if segue.identifier == "SegueForAddTask" {
            addNewTaskViewController = segue.destination as! AddTaskViewController
            addNewTaskViewController.taskStore = taskStore
        }
    }
    
    @IBAction func changeHeaderListSwitch(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        if headerListSwitch.isOn {
            defaults.set(true, forKey: "listSwitch")
        } else {
            defaults.set(false, forKey: "listSwitch")
        }
    }
    @IBAction func changeHeaderGridSwitch(_ sender: Any) {
        let defaults = UserDefaults.standard
        
        if headerListSwitch.isOn {
            defaults.set(true, forKey: "gridSwitch")
        } else {
            defaults.set(false, forKey: "gridSwitch")
        }
    }

    @IBAction func openMenu(_ sender: Any) {
        if (menuShowing) {
            leadingConstraint.constant = -210
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            
        } else {
            leadingConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
        menuShowing = !menuShowing
    }
    
}
