//
//  DetailViewController.swift
//  Instagram
//
//  Created by Oranuch on 3/6/16.
//  Copyright © 2016 horizon. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var media: PFObject?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeNavigationBar()
        
        let author = media!["author"]as? PFUser
        let userID = author?.objectId
        
        //queryUser(userID!)
        
        let query = PFQuery(className: "_User")
        query.limit = 20
        
        
        query.getObjectInBackgroundWithId(userID!){
            (user: PFObject?, error: NSError?) -> Void in
            if user != nil{
                //print(user!["username"])
                self.usernameLabel.text = user!["username"] as! String
            }
        }
        
        let userImageFile = media!["media"] as! PFFile
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    self.userImageView.image = image
                }
            }
        }

        titleLabel.text = media!["caption"] as! String
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
