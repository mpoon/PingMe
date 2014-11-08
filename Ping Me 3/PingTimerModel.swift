//
//  PingTimerModel.swift
//  Ping Me 3
//
//  Created by Josh Tabak on 10/18/14.
//  Copyright (c) 2014 pingme3. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PingTimerModel {
    class func shared() -> PingTimerModel {
        return _sharedPingTimer
    }

    let pollInterval:Float = 5.0
    let timeBufferSize = 10

    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

    init() {
        updateTimes()
    }
    
    func updateTimes() {
        var count = 0
        let fetchRequest = NSFetchRequest(entityName: "Schedule" as NSString)
        if let fetchResults = appDelegate.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Schedule] {
             // for val in fetchResults {
             //   println(val.offset);
             // }
            count = fetchResults.count
        }

        while(count < timeBufferSize) {
            
            var rand = Float(arc4random()) / Float(UINT32_MAX)

            let newItem = NSEntityDescription.insertNewObjectForEntityForName("Schedule", inManagedObjectContext: appDelegate.managedObjectContext!) as Schedule

            newItem.offset = log(rand) * pollInterval * -1

            appDelegate.managedObjectContext!.save(nil)

            count += 1
        }
    }
    
    func popTimes(num: Int) -> [Float] {
        var toReturn: [Float] = []
        
        let fetchRequest = NSFetchRequest(entityName: "Schedule" as NSString)
        if let fetchResults = appDelegate.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Schedule] {
            for val in fetchResults[0...num-1] {
                println("deleting")
                println(val.offset)
                toReturn.append(val.offset)
                appDelegate.managedObjectContext?.deleteObject(val)
            }
        }
        
        return toReturn;
    }
    
    func getTimes(num: Int) -> [Float] {
        var toReturn: [Float] = []

        for index in 1...num {
            var rand = Float(arc4random()) / Float(UINT32_MAX)
            toReturn.append(log(rand) * pollInterval * -1)
        }
        
        return toReturn
    }

}

let _sharedPingTimer: PingTimerModel = { PingTimerModel() }()
