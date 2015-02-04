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
        
        var fieldValues: [String] = [usernameField.text,passwordField.text]
        
        if find(fieldValues, "") != nil {
            
            // all fields are not filled in
            var alertViewController = UIAlertController(title: "Submission Error", message: "All fields need to be filled in.", preferredStyle: UIAlertControllerStyle.Alert)
            
            //            UIAlertAction * defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
            //            handler:^(UIAlertAction * action) {}];
            
            var defaultAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            
            alertViewController.addAction(defaultAction)
            
            presentViewController(alertViewController, animated: true, completion: nil)
            
        } else {
            
            // all fields are filled in
            
            println("all fields are good and login")
            
            var userQuery = PFUser.query()
            
            userQuery.whereKey("username", equalTo: usernameField.text)
            
            userQuery.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                
                if objects.count > 0 {
                    
                    self.login()
                    
                } else {
                    
                    self.signUp()
                    
                }
                
            })
            
            
            //            signUp()
            
            
        }
        
        
    }
    
    func login() {
        
        PFUser.logInWithUsernameInBackground(usernameField.text, password:passwordField.text) {
            (user: PFUser!, error: NSError!) -> Void in
            
            if user != nil {
                
                println("logged in as \(user)")
                // Do stuff after successful login.
                
                self.isLoggedIn = true

                self.checkIfLoggedIn()
                
            } else {
                // The login failed. Check error to see why.
            }
            
        }
        
    }
    
    func signUp() {
        
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
     
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            
            if error == nil {
                
                println(user)
                
                self.isLoggedIn = true
                
                self.checkIfLoggedIn()
                
                self.usernameField.text = ""
                self.passwordField.text = ""
   
                
                // Hooray! Let them use the app now.
                
            } else {
                
                let errorString = error.userInfo?["error"] as NSString
                // Show the errorString somewhere and let the user try again.
                
            }
            
        }
        
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

