//
//  Task.swift
//  4Tasks
//
//  Created by MingyuFan on 3/26/17.
//  Copyright © 2017 MingyuFan. All rights reserved.
//

import UIKit

enum Priority: Int {
    case UI = 0 //important and urgent
    case NUI = 1 //not urgent but important
    case UNI = 2//ugent but not important
    case NUNI = 3//not ugent not important
}
class Task: NSObject {
    var name: String
    var detail: String?
    var priority: Priority?
    let dateCreated: Date
    
    init(name: String, priority: Priority) {
        self.name = name
        self.priority = priority
        self.dateCreated = Date()
        
        super.init()
    }
    
    init(name: String) {
        self.name = name
        self.dateCreated = Date()
        super.init()
    }
    
    convenience init(random: Bool) {
        if random {
            let name = "wtf"
            let priority = Priority.NUI
            self.init(name: name,priority: priority)
        }
        else {
            self.init(name: "",priority: .NUI)
        }
    }
}
