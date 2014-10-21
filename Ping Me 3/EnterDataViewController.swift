//
//  EnterDataViewController.swift
//  Ping Me 3
//
//  Created by Michael L Poon on 10/18/14.
//  Copyright (c) 2014 pingme3. All rights reserved.
//

import UIKit
import CoreData

class EnterDataViewController: UIViewController {
    
    @IBOutlet var doingText : UITextField!
    var eventLog = EventLogModel.shared()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        eventLog.pushEvent(doingText.text)
        var managedObjectContext : NSManagedObjectContext? = {
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            if let managedObjectContext = appDelegate.managedObjectContext {
                return managedObjectContext
            }
            else {
                return nil
            }
            }()
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("LogEntry", inManagedObjectContext: managedObjectContext!) as LogEntry
        newItem.date = NSDate()
        newItem.tag = doingText.text
        
        managedObjectContext?.save(nil)
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
