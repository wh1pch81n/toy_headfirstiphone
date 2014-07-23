//
//  ViewController.swift
//  MarcoPollo
//
//  Created by Derrick Ho on 7/12/14.
//  Copyright (c) 2014 Derrick Ho. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController, UITextViewDelegate {
    @IBOutlet var tweetTextView : UITextView;
   
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tweetTextView.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func postItButtonPressed(sender : AnyObject) {
        println("Post It button was pressed: \(self.tweetTextView.text)");
        
        var tweetText:String = self.tweetTextView.text + "#MarcoPollo";
        
        var composer:SLComposeViewController = SLComposeViewController(forServiceType:SLServiceTypeTwitter);
        composer.setInitialText(tweetText);
        
        self.presentViewController(composer, animated: true, completion: nil);
        
    }
    
    //pragma uitextviewdelegate
    func textViewDidBeginEditing(textView:UITextView!) {
        println("began editing");
    }
    
}

