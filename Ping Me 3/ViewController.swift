//
//  ViewController.swift
//  Ping Me 3
//
//  Created by Michael L Poon on 10/18/14.
//  Copyright (c) 2014 pingme3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var eventLog = EventLogModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("asdf")
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Testing notidfications on iOS8"
        localNotification.alertBody = "Woww it works!!"
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

