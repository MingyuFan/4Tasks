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
        
        return newTask
    }
}
