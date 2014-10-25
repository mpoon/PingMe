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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        var managedObjectContext : NSManagedObjectContext? = {
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            if let managedObjectContext = appDelegate.managedObjectContext {
                return managedObjectContext
            }
            else {
                return nil
            }
            }()
        
        let fetchRequest = NSFetchRequest(entityName: "Tag")
        if var fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Tag] {
            persistentTags = fetchResults
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        var managedObjectContext : NSManagedObjectContext? = {
            let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
            if let managedObjectContext = appDelegate.managedObjectContext {
                return managedObjectContext
            }
            else {
                return nil
            }
            }()
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Entry", inManagedObjectContext: managedObjectContext!) as Entry
        newItem.date = NSDate()
        newItem.tag = doingText.text
        
//        let newItem2 = NSEntityDescription.insertNewObjectForEntityForName("Tag", inManagedObjectContext: managedObjectContext!) as Tag
//        newItem2.frequency = 1
//        newItem2.name = doingText.text
        
        managedObjectContext!.save(nil)
        
        let fetchRequest = NSFetchRequest(entityName: "Tag")
        if var fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Tag] {
            var notFound = true
            for result in fetchResults {
                if result.name == self.doingText.text {
                    result.frequency = result.frequency + 1
                    notFound = false
                    break
                }
            }
            if notFound {
                let newTag = NSEntityDescription.insertNewObjectForEntityForName("Tag", inManagedObjectContext: managedObjectContext!) as Tag
                newTag.name = doingText.text
                newTag.frequency = 1
                managedObjectContext!.save(nil)
            }
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
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
