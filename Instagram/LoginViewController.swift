//
//  LoginViewController.swift
//  Instagram
//
//  Created by Oranuch on 3/1/16.
//  Copyright © 2016 horizon. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
        
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        if PFUser.currentUser() != nil {

            self.performSegueWithIdentifier("loginSegue", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onSignIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(userNameTextField.text!, password: passwordTextField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("You're logged in!")
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }
        }
    }
    
    
    @IBAction func onSignUp(sender: AnyObject) {
        let newUser = PFUser()
        newUser.username = userNameTextField.text
        newUser.password = passwordTextField.text
        newUser.signUpInBackgroundWithBlock {(success: Bool, error: NSError?) -> Void in
            if success{
                print("User Created")
                self.performSegueWithIdentifier("loginSegue", sender: nil)
            }else {
                print(error?.localizedDescription)
                if error?.code == 202 {
                    print("User name is taken")
                }
            }
            
        }
        
    }
}
