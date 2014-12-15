//
//  EventLogViewController.swift
//  Ping Me 3
//
//  Created by Michael L Poon on 10/18/14.
//  Copyright (c) 2014 pingme3. All rights reserved.
//

import UIKit
import CoreData

class HistoryLogViewController: UITableViewController {
    
    var persistentEventLog: [Entry] = []
    var dateFormatter = NSDateFormatter()
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        loadTableData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadTableData()
    }
    
    func loadTableData() {
        let fetchRequest = NSFetchRequest(entityName: "Entry" as NSString)
        let onlyPast = NSPredicate(format: "%K < %@", "date", NSDate())
        
        fetchRequest.predicate = onlyPast
        
        if let fetchResults = appDelegate.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Entry] {
            persistentEventLog = fetchResults
            persistentEventLog.sort({
                item1, item2 in
                let date1 = item1.date as NSDate
                let date2 = item2.date as NSDate
                return date1.compare(date2) == NSComparisonResult.OrderedDescending
            })
        }
        
        self.tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "editLogItem") {
            var destController = segue.destinationViewController as EntryQueryViewController
            destController.indexToEdit = self.tableView.indexPathForCell(sender as UITableViewCell)?.row
    
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.persistentEventLog.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Historical Entries", forIndexPath: indexPath) as UITableViewCell
        cell.editing = true
        let entry = self.persistentEventLog[indexPath.row]
        cell.textLabel.text = entry.tag
        cell.detailTextLabel!.text = dateFormatter.stringFromDate(entry.date)
        return cell
    }
}
