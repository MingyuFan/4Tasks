//
//  TaskStore.swift
//  4Tasks
//
//  Created by MingyuFan on 3/26/17.
//  Copyright © 2017 MingyuFan. All rights reserved.
//

import UIKit

class TaskStore {
    var allTasks = Array(repeating:[Task](), count: 4)
    
    @discardableResult func createTask() -> Task {
        let newTask = Task(random: true)
        
        allTasks[0].append(newTask)
        allTasks[1].append(newTask)
        allTasks[2].append(newTask)
        allTasks[3].append(newTask)
        return newTask
    }
    @discardableResult func createTask(taskname: String, taskPriority: Priority) -> Task {
        let task = Task(name: taskname, priority: taskPriority)
        switch taskPriority {
        case Priority.UI:
            allTasks[0].append(task)
        case Priority.NUI:
            allTasks[1].append(task)
        case Priority.UNI:
            allTasks[2].append(task)
        case Priority.NUNI:
            allTasks[3].append(task)
        }
        return task
    }
}
