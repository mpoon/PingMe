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
    
    var pingTimer = PingTimerModel()
    @IBOutlet var powerLabel: UILabel!
    @IBOutlet var powerSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        powerSwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        if powerSwitch.on {
            var localNotification:UILocalNotification = UILocalNotification()
            localNotification.alertAction = "Testing notidfications on iOS8"
            localNotification.alertBody = "Woww it works!!"
            localNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        }
  
        var managedObjectContext : NSManagedObjectContext? = {
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            if let managedObjectContext = appDelegate.managedObjectContext {
                return managedObjectContext
            }
            else {
                return nil
            }
            }()
    }
    func stateChanged(switchState: UISwitch) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if powerSwitch.on {
            powerLabel.text = "On"
            appDelegate.powerState = true
        } else {
            powerLabel.text = "Off"
            appDelegate.powerState = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

