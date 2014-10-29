//
//  ViewController.swift
//  LoginSwift
//
//  Created by Jorge Casariego on 29/10/14.
//  Copyright (c) 2014 Jorge Casariego. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn = prefs.integerForKey("ISLOGGEDIN") as Int
        
        if(isLoggedIn != 1){
            self.performSegueWithIdentifier("goto_login", sender: true)
        } else{
            self.usernameLabel.text = prefs.valueForKey("USERNAME") as NSString
        }
        
    }

    @IBAction func logoutTapped(sender: UIButton) {
        let appDomain = NSBundle.mainBundle().bundleIdentifier
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain!)
        
        
        self.performSegueWithIdentifier("goto_login", sender: self)
    }

}

