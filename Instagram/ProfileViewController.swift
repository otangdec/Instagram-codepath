//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Oranuch on 3/5/16.
//  Copyright © 2016 horizon. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeNavigationBar()
    }
    
    func initializeNavigationBar(){
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
