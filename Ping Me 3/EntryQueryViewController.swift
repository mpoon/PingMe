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
    var indexToEdit:Int?
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let fetchRequest = NSFetchRequest(entityName: "Tag")
        if var fetchResults = appDelegate.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Tag] {
            persistentTags = fetchResults
            persistentTags.sort({
                item1, item2 in
                let freq1 = item1.frequency
                let freq2 = item2.frequency
                return freq1.compare(freq2) == NSComparisonResult.OrderedDescending
            })
        }
    }
    
    @IBAction func saveAndBack() {
        let fetchRequest = NSFetchRequest(entityName: "Entry")
        let onlyPast = NSPredicate(format: "%K < %@", "date", NSDate())
        
        fetchRequest.predicate = onlyPast
        
        if var fetchResults = appDelegate.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Entry] {
            fetchResults.sort({
                item1, item2 in
                let date1 = item1.date as NSDate
                let date2 = item2.date as NSDate
                return date1.compare(date2) == NSComparisonResult.OrderedDescending
            })
            fetchResults[indexToEdit!].tag = doingText.text
            appDelegate.managedObjectContext!.save(nil)
        }
        
        let tagFetchRequest = NSFetchRequest(entityName: "Tag")
        if var fetchResults = appDelegate.managedObjectContext!.executeFetchRequest(tagFetchRequest, error: nil) as? [Tag] {
            var notFound = true
            for result in fetchResults {
                if result.name == self.doingText.text {
                    result.frequency = NSNumber(int: result.frequency.intValue + 1)
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

        self.navigationController?.popViewControllerAnimated(true)
        self.navigationController?.reloadInputViews()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.persistentTags.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        let entry = self.persistentTags[indexPath.row]
        cell.textLabel.text = entry.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as UITableViewCell?
        doingText.text = cell?.textLabel.text
    }
}
