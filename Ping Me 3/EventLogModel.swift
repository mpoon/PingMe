//
//  EventLog.swift
//  Ping Me 3
//
//  Created by Michael L Poon on 10/18/14.
//  Copyright (c) 2014 pingme3. All rights reserved.
//

import Foundation

class EventLogModel {
    var events : [(timestamp: Int, entry: String)] = []
    
    init() {
        self.events = []
    }
}