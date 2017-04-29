//
//  AddTaskViewController.swift
//  4Tasks
//
//  Created by MingyuFan on 4/1/17.
//  Copyright © 2017 MingyuFan. All rights reserved.
//

import UIKit
import EventKit
import CoreLocation

class AddTaskViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, CLLocationManagerDelegate {
    
    var taskStore: TaskStore!
    var task: Task!
    var eventStore: EKEventStore!
    var reminder: EKReminder?
    var locationReminder: EKReminder?//when leave current place
    var locationManager: CLLocationManager!
    @IBOutlet var Save: UIBarButtonItem!
    
    var priority: Priority?
    var TaskName: String?
    var Detail: String?
    
    @IBOutlet var DetailTextView: UITextView!
    
    //Navigation stack buttons
    @IBOutlet weak var goToPriorityButton: UIButton!
    @IBOutlet var reminderButton: UIButton!
    @IBOutlet weak var goToLocationButton: UIButton!
    @IBOutlet weak var navigationEmptyView: UIView!

    //buttons
    @IBOutlet var UI: UIButton!
    @IBOutlet var NUI: UIButton!
    @IBOutlet var UNI: UIButton!
    @IBOutlet var NUNI: UIButton!
    
    //date Pick view vars
    @IBOutlet var deleteReminderButton: UIButton!
    @IBOutlet var setReminderButton: UIButton!
    @IBOutlet weak var myDatePicker: UIDatePicker!
    
    //location view
    @IBOutlet weak var locationLeavingSwitch: UISwitch!
        
    //Reminder View Constraints
    @IBOutlet weak var reminderViewLeading: NSLayoutConstraint!
    @IBOutlet weak var reminderViewTrailing: NSLayoutConstraint!
    //Location View Constraints
    @IBOutlet weak var locationViewLeading: NSLayoutConstraint!
    @IBOutlet weak var locationViewTrailing: NSLayoutConstraint!
    //Colors
    var blueColor = UIColor(red: 0, green: 0.6, blue: 0.8, alpha: 1)
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .full
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //update location information
        locationManager.startUpdatingLocation()
        let toolbar = UIToolbar()
        toolbar.bounds = CGRect(x: 0, y: 0, width: 320, height: 50)
        toolbar.sizeToFit()
        toolbar.barStyle = UIBarStyle.default
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil), UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(handleDone(sender:)))
        ]
        
        reminderButton.setTitle("Time", for: .normal)
        goToPriorityButton.setTitle("Priority", for: .normal)
        goToLocationButton.setTitle("Location", for: .normal)
        
        self.DetailTextView.inputAccessoryView = toolbar
        
        deleteReminderButton.setTitle("Delete", for: .normal)
        setReminderButton.setTitle("Set", for: .normal)
        
        //set Navigation font and background color
        goToPriorityButton.setTitleColor(UIColor.white, for: .normal)
        goToLocationButton.setTitleColor(UIColor.white, for: .normal)
        reminderButton.setTitleColor(UIColor.white, for: .normal)
        //set navigation color
        
        goToPriorityButton.backgroundColor = blueColor
        goToLocationButton.backgroundColor = blueColor
        reminderButton.backgroundColor = blueColor
        navigationEmptyView.backgroundColor = blueColor
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reminderViewLeading.constant = 400
        reminderViewTrailing.constant = -400
        
        locationViewLeading.constant = 400
        locationViewTrailing.constant = -400
        
        locationLeavingSwitch.isOn = false
    }
    
    //create new task and save it, return to previous view
    @IBAction func SaveNewTask(_ sender: Any) {
        if let name = TaskName {
            if let pri = priority {
               task = taskStore.createTask(taskname: name, taskPriority: pri)
                if let text = DetailTextView.text {
                    Detail = text
                    task.detail = Detail
                }
                if (reminder != nil) {
                    reminder?.title = name
                    reminder?.notes = "Task: \(name) needs to be done!"
                    task.reminderIdentifier = reminder?.calendarItemIdentifier
                    //task.reminder?.title = name
                    print("set title")
                } else {
                    task.reminderIdentifier = nil
                }
                if locationLeavingSwitch.isOn {
                    remindLeavingCurrentLocation()
                    locationReminder?.title = task.name
                    locationReminder?.notes = "You are leaving current location"
                    task.locationReminderIdentifier = locationReminder?.calendarItemIdentifier
                }
                _ = navigationController?.popViewController(animated: true)
            } else {
                let message = "Please select Priority"
                let ac = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                ac.addAction(cancelAction)
                present(ac, animated: true, completion: nil)
            }
        } else {
            let message = "Please name the Task"
            let ac = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            present(ac, animated: true, completion: nil)

        }
    }
    
    @IBAction func inputTask(_ sender: UITextField) {
        if let text = sender.text {
            TaskName = text
        }
    }

    @IBAction func touchUIButton(_ sender: UIButton) {
        priority = Priority.UI
        UI.backgroundColor = UIColor.lightGray
        NUI.backgroundColor = UIColor.white
        UNI.backgroundColor = UIColor.white
        NUNI.backgroundColor = UIColor.white
    }

    @IBAction func touchNUIButton(_ sender: UIButton) {
        priority = Priority.NUI
        UI.backgroundColor = UIColor.white
        NUI.backgroundColor = UIColor.lightGray
        UNI.backgroundColor = UIColor.white
        NUNI.backgroundColor = UIColor.white
    }
    
    @IBAction func touchUNIButton(_ sender: UIButton) {
        priority = Priority.UNI
        UI.backgroundColor = UIColor.white
        NUI.backgroundColor = UIColor.white
        UNI.backgroundColor = UIColor.lightGray
        NUNI.backgroundColor = UIColor.white
    }
    @IBAction func touchNUNIButton(_ sender: UIButton) {
        priority = Priority.NUNI
        UI.backgroundColor = UIColor.white
        NUI.backgroundColor = UIColor.white
        UNI.backgroundColor = UIColor.white
        NUNI.backgroundColor = UIColor.lightGray
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func handleDone(sender: UIButton) {
        self.DetailTextView.resignFirstResponder()
    }
    //Navigation  Priority
    @IBAction func goToPriorityClearOthers(_ sender: UIButton) {
        backToPriority()
    }
    //Navigation Reminder
    @IBAction func setMyReminder(_ sender: UIButton) {
        if let re = reminder {
            myDatePicker.date = (re.alarms?[0].absoluteDate!)!
        }
        goToReminderWithoutButton()
    }
    //Navigation Location
    @IBAction func goToLocationSetting(_ sender: UIButton) {
        goToLocationWithoutButton()
    }
    

    @IBAction func deleteReminder(_ sender: UIButton) {
        if(reminder != nil) {
        do {
            try eventStore.remove(reminder!, commit: true)
        } catch {
            print("Failed to remove reminder")
        }
        reminder = nil
        }
        backToPriority()
        setReminderButton.setTitle("Set", for: .normal)
        //leftLeadingConstraints.constant = 360
    }
    @IBAction func setReminderAndBacktoView(_ sender: UIButton) {
        if reminder == nil {
            reminder = EKReminder(eventStore: eventStore)
            reminder?.calendar = eventStore.defaultCalendarForNewReminders()
        }        
        let date = myDatePicker.date
        let alarm = EKAlarm(absoluteDate: date)
        if (reminder?.hasAlarms)! {
            reminder?.removeAlarm((reminder?.alarms?[0])!)
        }
        reminder?.addAlarm(alarm)
        do {
            try eventStore.save(reminder!,commit: true)
        } catch let error {
            print("Reminder failed with error \(error.localizedDescription)")
        }
        //!!!!!!!==============================
        //let text = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .short)
       // reminderButton.setTitle("Remind me at: \(text)", for: .normal)
        print("Reminder set")
        
        //backToPriority()
        setReminderButton.setTitle("Reset", for: .normal)
    }
    
    func backToPriority() {
        
        reminderViewLeading.constant = 400
        reminderViewTrailing.constant = -400
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        locationViewLeading.constant = 400
        locationViewTrailing.constant = -400
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        goToPriorityButton.setTitleColor(blueColor, for: .normal)
        goToLocationButton.setTitleColor(UIColor.white, for: .normal)
        reminderButton.setTitleColor(UIColor.white, for: .normal)
        //set navigation color
        
        goToPriorityButton.backgroundColor = UIColor.white
        goToLocationButton.backgroundColor = blueColor
        reminderButton.backgroundColor = blueColor
    }
    
    func goToReminderWithoutButton() {
        
        locationViewLeading.constant = 400
        locationViewTrailing.constant = -400
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        reminderViewLeading.constant = 0
        reminderViewTrailing.constant = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        goToPriorityButton.setTitleColor(UIColor.white, for: .normal)
        goToLocationButton.setTitleColor(UIColor.white, for: .normal)
        reminderButton.setTitleColor(blueColor, for: .normal)
        //set navigation color
        
        goToPriorityButton.backgroundColor = blueColor
        goToLocationButton.backgroundColor = blueColor
        reminderButton.backgroundColor = UIColor.white
    }
    
    func goToLocationWithoutButton() {
        reminderViewLeading.constant = 400
        reminderViewTrailing.constant = -400
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        locationViewLeading.constant = 0
        locationViewTrailing.constant = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        goToPriorityButton.setTitleColor(UIColor.white, for: .normal)
        goToLocationButton.setTitleColor(blueColor, for: .normal)
        reminderButton.setTitleColor(UIColor.white, for: .normal)
        //set navigation color
        
        goToPriorityButton.backgroundColor = blueColor
        goToLocationButton.backgroundColor = UIColor.white
        reminderButton.backgroundColor = blueColor
    }
    
    //location protocal
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
    //create location reminder
    func remindLeavingCurrentLocation() {
        locationReminder = EKReminder(eventStore: eventStore)
        locationReminder?.calendar = eventStore.defaultCalendarForNewReminders()
        print("location Protocal works?")
        let location = EKStructuredLocation(title: "Current Location")
        location.geoLocation = locationManager.location
        let alarm = EKAlarm()
        
        alarm.structuredLocation = location
        alarm.proximity = EKAlarmProximity.leave
        
        locationReminder?.addAlarm(alarm)
        
        do {
            try eventStore.save(locationReminder!,commit: true)
            print("Location Reminder saved!!!!")
        } catch let error {
            print("Location reminder failed with error \(error.localizedDescription)")
        }
    }
}
