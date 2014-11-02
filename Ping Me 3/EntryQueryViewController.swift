//
//  EnterDataViewController.swift
//  Ping Me 3
//
//  Created by Michael L Poon on 10/18/14.
//  Copyright (c) 2014 pingme3. All rights reserved.
//

import UIKit
import CoreData

class EntryQueryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var doingText : UITextField!
    @IBOutlet var tableView: UITableView!
    var persistentTags: [Tag] = []
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let fetchRequest = NSFetchRequest(entityName: "Tag")
        if var fetchResults = appDelegate.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Tag] {
            persistentTags = fetchResults
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Entry", inManagedObjectContext: appDelegate.managedObjectContext!) as Entry
        newItem.date = NSDate()
        newItem.tag = doingText.text
        
        appDelegate.managedObjectContext!.save(nil)
        
        let fetchRequest = NSFetchRequest(entityName: "Tag")
        if var fetchResults = appDelegate.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Tag] {
            var notFound = true
            for result in fetchResults {
                if result.name == self.doingText.text {
                    result.frequency = result.frequency + 1
                    notFound = false
                    break
                }
            }
            if notFound {
                let newTag = NSEntityDescription.insertNewObjectForEntityForName("Tag", inManagedObjectContext: appDelegate.managedObjectContext!) as Tag
                newTag.name = doingText.text
                newTag.frequency = 1
                appDelegate.managedObjectContext!.save(nil)
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.persistentTags.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        let entry = self.persistentTags[indexPath.row]
        cell.textLabel!.text = entry.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell?
        doingText.text = cell?.textLabel?.text
    }
}
