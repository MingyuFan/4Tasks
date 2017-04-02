//
//  mainViewController.swift
//  4Tasks
//
//  Created by MingyuFan on 3/29/17.
//  Copyright © 2017 MingyuFan. All rights reserved.
//
//  3/29/2017 redesign structure, use container view
//  4/1/2017  main structure done, data transmission done

import UIKit

class mainViewController: UIViewController {
    var taskStore: TaskStore!
    var containerViewController: UITabBarController!
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
    }
}
