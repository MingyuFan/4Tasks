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
    let taskArchiveURL: URL = {
       let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("tasks.archive")
    }()
    @discardableResult func createTask() -> Task {
        let newTask = Task(random: true)
        
        allTasks[0].append(newTask)
        allTasks[1].append(newTask)
        allTasks[2].append(newTask)
        allTasks[3].append(newTask)
        return newTask
    }
    init() {
        if let archivedTasks = NSKeyedUnarchiver.unarchiveObject(withFile: taskArchiveURL.path) as? [[Task]] {
            allTasks = archivedTasks
        }
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
    
    func removeTask(_ task: Task) {
        var grid:Int!
        let p = task.priority
        switch p! {
        case Priority.UI:
            grid = 0
        case Priority.NUI:
            grid = 1
        case Priority.UNI:
            grid = 2
        case Priority.NUNI:
            grid = 3
        }
        if let index = allTasks[grid].index(of: task) {
            allTasks[grid].remove(at: index)
        }
    }
    
    func insertTask(_ task: Task) {
        var grid:Int!
        let p = task.priority
        switch p! {
        case Priority.UI:
            grid = 0
        case Priority.NUI:
            grid = 1
        case Priority.UNI:
            grid = 2
        case Priority.NUNI:
            grid = 3
        }
        allTasks[grid].insert(task, at: 0)
    }
    
    func saveChanges() -> Bool {
        print("Saving items to: \(taskArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allTasks, toFile: taskArchiveURL.path)
    }
    
}
