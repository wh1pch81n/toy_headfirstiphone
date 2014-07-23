//
//  DetailViewController.swift
//  SpinCity
//
//  Created by Derrick Ho on 7/13/14.
//  Copyright (c) 2014 Derrick Ho. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
   
    
    @IBOutlet var detailTitle: UILabel
    @IBOutlet var detailPrice: UILabel
    @IBOutlet var detailArtist: UILabel
    @IBOutlet var detailLocation: UILabel
    @IBOutlet var detailSummary: UITextView

    
    
    var detailItem: AlbumModel? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder);
    }
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    }
    init(style: UITableViewStyle)  {
        super.init(style: style);
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem{
            println(detail.description());
            println(detail.name);
            if let title = self.detailTitle {
                self.detailTitle.text = detail.name
            }
            if let price = self.detailPrice {
                self.detailPrice.text = NSString(format: "$%01.2f", detail.price)
            }
            if let artist = self.detailArtist {
                self.detailArtist.text = detail.artistName
            }
            if let location = self.detailLocation {
                self.detailLocation.text = detail.location
            }
            if let summary = self.detailSummary {
                self.detailSummary.text = detail.detail
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

