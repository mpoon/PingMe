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

    let pollInterval:Float =  60 * 45 // 45 minutes

    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

    init() {
    }
    
    func getFarthestDate() -> NSDate? {
        var toReturn:NSDate? = nil

        let fetchRequest = NSFetchRequest(entityName: "Entry")
        if var fetchResults = appDelegate.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Entry] {
            fetchResults.sort({
                item1, item2 in
                let date1 = item1.date as NSDate
                let date2 = item2.date as NSDate
                return date1.compare(date2) == NSComparisonResult.OrderedDescending
            })
            
            if (fetchResults.count > 0) {
                toReturn = fetchResults[0].date
                println("farthestDate?: ", toReturn!.description)
            }
            else {
                println("no future dates. now: " + NSDate().description)
            }
        }
        
        return toReturn
    }

    func insertTimes(num: Int, start: NSDate?) -> [Double] {
        var count = 0
        var cumulativeOffset:Double = 0
        var startDate: NSDate
        var toReturn: [Double] = []
        
        if (start == nil) {
            startDate = NSDate()
        } else {
            startDate = start!
        }

        while(count < num) {
            
            var rand = Float(arc4random()) / Float(UINT32_MAX)

            let newItem = NSEntityDescription.insertNewObjectForEntityForName("Entry", inManagedObjectContext: appDelegate.managedObjectContext!) as Entry

            cumulativeOffset += Double(log(rand) * pollInterval * -1)
            toReturn.append(cumulativeOffset)

            newItem.date = NSDate(timeInterval: cumulativeOffset, sinceDate: startDate)
            newItem.tag = ""
            appDelegate.managedObjectContext!.save(nil)
            
            println(newItem.date)

            count += 1
        }
        
        return toReturn
    }

}

let _sharedPingTimer: PingTimerModel = { PingTimerModel() }()
