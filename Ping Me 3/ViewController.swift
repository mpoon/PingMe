//
//  ViewController.swift
//  Ping Me 3
//
//  Created by Michael L Poon on 10/18/14.
//  Copyright (c) 2014 pingme3. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var eventLog = EventLogModel()
    var pingTimer = PingTimerModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Testing notidfications on iOS8"
        localNotification.alertBody = "Woww it works!!"
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
  
        var managedObjectContext : NSManagedObjectContext? = {
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            if let managedObjectContext = appDelegate.managedObjectContext {
                return managedObjectContext
            }
            else {
                return nil
            }
            }()
        
        let fetchRequest = NSFetchRequest(entityName: "LogEntry")
        if var fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [LogEntry] {
            println("fetch log entry")
            for result in fetchResults {
                println(result.tag)
                println(result.date)
            }
        }
        
        let fetchRequest2 = NSFetchRequest(entityName: "Tag")
        if var fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest2, error: nil) as? [Tag] {
            println("fetch tags")
            for result in fetchResults {
                println(result.name)
                println(result.frequency)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

