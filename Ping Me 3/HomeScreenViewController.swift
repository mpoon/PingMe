//
//  ViewController.swift
//  Ping Me 3
//
//  Created by Michael L Poon on 10/18/14.
//  Copyright (c) 2014 pingme3. All rights reserved.
//

import UIKit
import CoreData

class HomeScreenViewController: UIViewController {
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var pingTimer = PingTimerModel()
    var dateFormatter = NSDateFormatter()

    @IBOutlet var powerLabel: UILabel!
    @IBOutlet var powerSwitch: UISwitch!
    @IBOutlet var notificationsText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle

        powerSwitch.addTarget(self, action: Selector("powerStateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    func powerStateChanged(switchState: UISwitch) {
        if powerSwitch.on {
            powerLabel.text = "On"
            self.appDelegate.powerState = true

            scheduleLocalNotifications()
        } else {
            powerLabel.text = "Off"
            self.appDelegate.powerState = false
            UIApplication.sharedApplication().cancelAllLocalNotifications()
        }
    }
    
    func scheduleLocalNotifications() {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        var startDate:NSDate? = PingTimerModel.shared().getFarthestDate()
        var date:NSDate = NSDate()
        
        if (startDate == nil) {
            startDate = NSDate()
        }

        for cumulativeOffset in PingTimerModel.shared().insertTimes(40, start: startDate) {
            var localNotification:UILocalNotification = UILocalNotification()
            localNotification.alertAction = "Log your status"
            localNotification.soundName = UILocalNotificationDefaultSoundName

            date = NSDate(timeInterval: cumulativeOffset, sinceDate: startDate!)

            localNotification.alertBody = "What are you doing right now? \(dateFormatter.stringFromDate(date))"
            localNotification.fireDate = NSDate(timeIntervalSinceNow: Double(cumulativeOffset))
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        }
        
        notificationsText.text = "Notications Until: " + dateFormatter.stringFromDate(date)
    }
}

