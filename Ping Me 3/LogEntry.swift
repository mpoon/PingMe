//
//  LogEntry.swift
//  Ping Me 3
//
//  Created by Michael L Poon on 10/19/14.
//  Copyright (c) 2014 pingme3. All rights reserved.
//

import Foundation
import CoreData

class LogEntry: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var tag: String

}
