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
    @IBOutlet var powerLabel: UILabel!
    @IBOutlet var powerSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        }
    }
    
    func scheduleLocalNotifications() {
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Testing notifications on iOS8"
        localNotification.alertBody = "What are you doing right now?"
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
}

