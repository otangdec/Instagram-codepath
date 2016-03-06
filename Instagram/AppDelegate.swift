//
//  AppDelegate.swift
//  Instagram
//
//  Created by Oranuch on 3/1/16.
//  Copyright © 2016 horizon. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard = UIStoryboard(name: "Main", bundle: nil)


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: "userDidLogoutNotification", object: nil)
        // Override point for customization after application launch.
        initializeParse()
        
        if PFUser.currentUser() != nil {
            print("persist")
            // if there is a logged in user then load the home view controller
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: "userDidLogoutNotification", object: nil)
        
        if let _  = PFUser.currentUser(){
            // Go to the logged in screen
            let vc = storyboard.instantiateViewControllerWithIdentifier("HomeNavigationController")
            
            window?.rootViewController = vc
        }
        
        initializeTabBar()
        return true
    }
    
    func userDidLogout() {
        let vc = storyboard.instantiateInitialViewController()! as UIViewController
        window?.rootViewController = vc
}

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func initializeParse() {
        Parse.initializeWithConfiguration(
            ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "Instagram"
                configuration.clientKey = "sdfdsfhsjdhfawuehfjksdhfluewhljvblmanvjkdalhfiuewhakfjbnladsnkfjasdfadf"
                configuration.server = "https://sleepy-badlands-62850.herokuapp.com/parse"
            })
        )
    }

    func initializeTabBar() {
        //first tab item
        let homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeNavigationController") as! UINavigationController
        homeViewController.tabBarItem.title = "Home"
        homeViewController.tabBarItem.image = UIImage(named: "home")
        
        //second tab item
        let photoViewController = storyboard.instantiateViewControllerWithIdentifier("PhotoViewNavigationController")

        photoViewController.tabBarItem.title = "Photo"
        photoViewController.tabBarItem.image = UIImage(named: "instagram")
        
        //Third tab item
        let profileViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileViewNavigationController")
        profileViewController.tabBarItem.title = "Me"
        profileViewController.tabBarItem.image = UIImage(named: "profile")
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [homeViewController, photoViewController, profileViewController]
        tabBarController.tabBar.tintColor = UIColor(red: 63/255, green: 114/255, blue: 155/255, alpha: 1)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

}

