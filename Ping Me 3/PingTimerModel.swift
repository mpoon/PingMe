//
//  PingTimerModel.swift
//  Ping Me 3
//
//  Created by Josh Tabak on 10/18/14.
//  Copyright (c) 2014 pingme3. All rights reserved.
//

import Foundation

class PingTimerModel {
    class func shared() -> PingTimerModel {
        return _sharedPingTimer
    }
    
    var times: [Int]
    let initTime = 1413687458 // When I wrote this code. 10/19/2014 @ 2:57am in UTC
  //  var pollInterval = 60.0
    
    init() {
        times = []
        getTimes(10)
    }
    
    func getTimes(limit: Int) {
        var count = 0

        while(count < limit) {
            
            var rand = Float(arc4random()) / Float(UINT32_MAX)
            
           // rand()
            println(log(rand) * 60.0 * -1)
            
           /// log(<#x: Double#>)
            
            count = count + 1
        }
    }

}

let _sharedPingTimer: PingTimerModel = { PingTimerModel() }()
