//
//  MyFeedTableViewController.swift
//  Sit Fit
//
//  Created by Jide Opeola on 2/3/15.
//  Copyright (c) 2015 Jide Opeola. All rights reserved.
//

import UIKit

class MyFeedTableViewController: FeedTableViewController {

    
    override func refreshFeed() {
        
        // time capsle that this opens up when it wants to
        FeedData.mainData().refreshMyFeedItems { () -> () in
            
            // reloadsData on the table view
            self.tableView.reloadData()
            
        }
        
        
    }
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
    
//        // time capsle that this opens up when it wants to
//        FeedData.mainData().refreshFeedItems { () -> () in
//            
//            // reloadsData on the table view
//            self.tableView.reloadData()
//            
//        }
//        
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//        
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
        
   

}
