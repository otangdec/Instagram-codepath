//
//  ViewController.swift
//  Instagram
//
//  Created by Oranuch on 3/1/16.
//  Copyright © 2016 horizon. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray: [PFObject]?
    var userArray: [PFObject]?
    var refreshControl:UIRefreshControl!
    var userName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        initializeRefreshControl()
        initializeNavigationBar()
        
        let queryPost = PFQuery(className: "Post")
        queryPost.orderByDescending("_created_at")
        queryPost.limit = 20
        
        queryPost.findObjectsInBackgroundWithBlock { (data: [PFObject]?, error: NSError?) -> Void in
            if data != nil{
                self.dataArray = data
                self.tableView.reloadData()
                print("Got data from Parse")
            } else {
                print("Something Wrong: \(error?.localizedDescription)")
            }
        }
        

    }
    
    func initializeNavigationBar(){
        self.navigationItem.title = "Home"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)
    }
    
    func queryUser(id:String ) {
        let query = PFQuery(className: "_User")
        query.limit = 20
        
        
        query.getObjectInBackgroundWithId(id){
            (user: PFObject?, error: NSError?) -> Void in
            if error == nil{
                //print(user!["username"])
                self.userName = user!["username"] as! String
                //cell.userNameLabel.text = user!["username"] as! String
                
            } else {
                self.userName = ""
            }
        }
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataArray != nil {
            return dataArray!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        let cell = tableView.dequeueReusableCellWithIdentifier("homeImageCell", forIndexPath: indexPath) as! HomeImageCell
        let media = dataArray![indexPath.row]
//        var createdAt: NSDictionary
//        var createdAtDate: NSDate
//        var createdAtString: String
        //print(media)
        
        cell.titleLabel.text = media["caption"] as? String
        let author = media["author"]as? PFUser
        let userID = author?.objectId
        
        //queryUser(userID!)
        
        let query = PFQuery(className: "_User")
        query.limit = 20
        
        
        query.getObjectInBackgroundWithId(userID!){
            (user: PFObject?, error: NSError?) -> Void in
            if user != nil{
                //print(user!["username"])
                cell.usernameLabel.text = user!["username"] as! String
                let createdTime = user!["_created_at"]
            }
        }
        
        let userImageFile = media["media"] as! PFFile
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.userImageView.image = image
                }
            }
        }
        MBProgressHUD.hideHUDForView(self.view, animated: true)
        return cell
    }
    
    func refresh(sender: AnyObject) {
        let query = PFQuery(className: "Post")
        query.orderByDescending("_created_at")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if media != nil {
                self.dataArray = media
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        self.refreshControl.endRefreshing()
    }
    
    func initializeRefreshControl(){
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        NSNotificationCenter.defaultCenter().postNotificationName("userDidLogoutNotification", object: nil)
    }
}

