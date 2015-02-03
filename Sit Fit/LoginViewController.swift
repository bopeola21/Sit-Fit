//
//  ViewController.swift
//  Sit Fit
//
//  Created by Jide Opeola on 2/3/15.
//  Copyright (c) 2015 Jide Opeola. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var buttonButtomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        checkIfLoggedIn()
        
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillShowNotification, object: nil, queue: NSOperationQueue.mainQueue()) { (notification) -> Void in
            
            if let kbSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size {
                
      //    does not animate because of constraints you have to do self.view.layoutIfNeeded()
              self.buttonButtomConstraint.constant = 20 + kbSize.height
                
                self.view.layoutIfNeeded()
    // animates
     //           self.view.frame.origin.y = -kbSize.height
            
            }
            
        }
            
            
        NSNotificationCenter.defaultCenter().addObserverForName(UIKeyboardWillHideNotification, object: nil, queue: NSOperationQueue.mainQueue(), usingBlock: { (notification) -> Void in
            

                self.buttonButtomConstraint.constant = 20
                
                self.view.layoutIfNeeded()

                
            })
        
            
        }
    
        
    @IBAction func loginRegister(sender: AnyObject) {
    
        isLoggedIn = true
        
        checkIfLoggedIn()
    
    }
    
    var isLoggedIn: Bool {
        
        get {
            
            return NSUserDefaults.standardUserDefaults().boolForKey("isLoggedIn")
         
        }
        
        set {
            
            NSUserDefaults.standardUserDefaults().setBool(newValue, forKey: "isLoggedIn")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            
        }
        
        
    }
    
    func checkIfLoggedIn() {
        
        if isLoggedIn {
            
        var tbc = storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as? UITabBarController
            
            //main shared standard and default Apple singletons
            // replace this controller with the tabbarcontroller
            UIApplication.sharedApplication().keyWindow?.rootViewController = tbc
 
            
        }
        
        
    }
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

