//
//  Tag.swift
//  Ping Me 3
//
//  Created by Michael L Poon on 10/20/14.
//  Copyright (c) 2014 pingme3. All rights reserved.
//

import Foundation
import CoreData

class Tag: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var frequency: NSNumber

}
