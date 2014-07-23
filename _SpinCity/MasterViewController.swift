//
//  MasterViewController.swift
//  SpinCity
//
//  Created by Derrick Ho on 7/13/14.
//  Copyright (c) 2014 Derrick Ho. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var _albumbDataController:AlbumDataController = AlbumDataController();
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        self.navigationItem.title = "Spin city Albums";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 

    // #pragma mark - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showAlbumDetails" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            let album = _albumbDataController.albumAtIndex(indexPath.row);
            (segue.destinationViewController as DetailViewController).detailItem = album;
        }
    }

    // #pragma mark - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._albumbDataController.albumCount();
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AlbumCell", forIndexPath: indexPath) as AlbumTableViewCell

        var album = _albumbDataController.albumAtIndex(indexPath.row);
        cell.albumTitle.text = album.name
        cell.albumSummary.text = album.detail
        cell.price.text = NSString(format:"$%01.2f", album.price);
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}

