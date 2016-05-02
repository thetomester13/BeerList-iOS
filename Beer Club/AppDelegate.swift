//
//  AppDelegate.swift
//  Beer Club
//
//  Created by Schvindt, Lucas S on 4/18/16.
//  Copyright © 2016 TTSLucas. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let breweries = BreweryList().breweries

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //saveData()
        
        return true
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
    
    func saveData() { //Writes data to the database
        // Firebase connection
        //let ref = Firebase(url:"https://beerclub2.firebaseio.com")
        let ref = Firebase(url: "https://beer-finder.firebaseio.com/")
        
        let birdSong = [
            "nickname": "Birdsong",
            "logo": "birdsong.png",
            "description": "Birdsong Brewing was founded in 2011 by a group of friends who share a love for both great beer and great people. We started with a five-gallon soup kettle and a vision inspired by some of our favorite craft breweries. The idea was simple: brew flavorful, unfiltered quality craft beer and bring that to Charlotte, NC.",
            "tourTime": "Thursdays at 6:30pm",
            "addressLink": "http://maps.apple.com/?address=1016,North+Davidson+Street,Charlotte,North+Carolina"
        ]
        
        let breweriesRef = ref.childByAppendingPath("breweries")
        
        let tempBreweries = ["1": birdSong]
        
        let breweriesDictionary = NSMutableDictionary()
        
        for brewery in breweries {
            let breweryJson = [
                "id" : brewery.id,
                "name" : brewery.name,
                "nickname" : brewery.nickname,
                "logo" : brewery.logo,
                "description" : brewery.description,
                "tourTime" : brewery.tourTime,
                "addressLink" : brewery.addressLink
            ]
            
            breweriesDictionary.setValue(breweryJson, forKey: brewery.id)
        }
        
        breweriesRef.setValue(breweriesDictionary)
        
    }


}

