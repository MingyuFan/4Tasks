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
class Task: NSObject, NSCoding {
    var name: String
    var detail: String?
    var priority: Priority!
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
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(detail, forKey: "detail")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encode(priority?.rawValue, forKey: "priority")
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        priority = Priority(rawValue: aDecoder.decodeObject(forKey: "priority") as! Int)
        detail = aDecoder.decodeObject(forKey: "detail") as! String?
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date
        
        super.init()
    }
}
