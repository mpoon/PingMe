//
//  EventLog.swift
//  Ping Me 3
//
//  Created by Michael L Poon on 10/18/14.
//  Copyright (c) 2014 pingme3. All rights reserved.
//

import Foundation

class EventLogModel {
    class func shared() -> EventLogModel {
        return _sharedInstance
    }
    
    var events : [(timestamp: NSDate, entry: String)]
    
    init() {
        self.events = []
    }
    
    func pushEvent(event: String) {
        self.events.append((timestamp: NSDate(), entry: event))
    }
}

let _sharedInstance: EventLogModel = { EventLogModel() }()
